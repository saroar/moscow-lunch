class User < ActiveRecord::Base
  rolify
  before_create :become_admin!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  belongs_to :organization
  has_many :orders, dependent: :destroy

  validates :name, presence: true, length: { in: 1..100 }
  #validates :organization, presence: true

  def self.from_omniauth(auth)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
        provider:auth.provider,
        uid:auth.uid,
        name: auth.info.name,
        email:auth.info.email,
        password:Devise.friendly_token[0,20],
        )
      end
    end
  end

  def today_orders
    date = Time.now
    self.orders.where(created_at: date.beginning_of_day..date.end_of_day)
  end

  def become_admin!
    if ! User.any?
      self.add_role "admin"
    end
  end
end
