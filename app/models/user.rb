class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { superadmin: 0, admin: 1, manager: 2, associate: 3, tenant: 4, room_partner: 5 }

  before_create :set_username

  has_many :houses, foreign_key: :owner_id, dependent: :destroy 

  def set_username
    self.username = "#{firstname}_#{lastname}".gsub(/\s+/, "")
  end

end
