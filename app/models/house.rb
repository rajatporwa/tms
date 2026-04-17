class House < ApplicationRecord
	belongs_to :owner, class_name: "User", foreign_key: "owner_id"

	has_many :house_rooms, dependent: :destroy
	has_many :expenses, dependent: :destroy
	has_many_attached :house_images

	after_create :create_rooms

	private

	def create_rooms
    (1..no_of_rooms).each do |i|
      house_rooms.create(room_number: i, status: :vacant, rent: 4000)
    end
	end
end
