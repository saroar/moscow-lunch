class User < ActiveRecord::Base
  rolify
  before_create :become_admin!
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  def become_admin!
    if ! User.any?
      self.add_role "admin"
    end
  end
end
