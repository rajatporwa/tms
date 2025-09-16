class House < ApplicationRecord
	belongs_to :owner, class_name: "User", foreign_key: "owner_id"

	has_many :house_rooms, dependent: :destroy

	has_many_attached :house_images
end
