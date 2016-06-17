# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  organization_id        :integer
#  uid                    :string
#  provider               :string
#  auth_token             :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  rolify
  before_create :become_admin!
  before_create :generate_authentication_token!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  belongs_to :organization
  has_many :orders, dependent: :destroy

  validates :name, uniqueness: true, presence: true, length: { in: 1..100 }

  def self.from_omniauth(auth, organization)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user
      return user
    else
      registered_user = User.where(email: auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
          provider: auth.provider,
          uid: auth.uid,
          name: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token[0, 20],
          organization: organization
        )
      end
    end
  end

  def today_orders
    date = Time.now
    orders.where(created_at: date.beginning_of_day..date.end_of_day)
  end

  private

  def become_admin!
    add_role 'admin' unless User.any?
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
