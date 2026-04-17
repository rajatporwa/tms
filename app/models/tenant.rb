
class Tenant < ApplicationRecord
  belongs_to :house_room
  has_many :payments, dependent: :destroy
  has_many :rents, dependent: :destroy

  has_one_attached :profile_photo
  has_one_attached :document_file

  has_many :tenant_partners, dependent: :destroy
  accepts_nested_attributes_for :tenant_partners, allow_destroy: true

  has_many :vehicles, as: :owner, dependent: :destroy
  accepts_nested_attributes_for :vehicles, allow_destroy: true, reject_if: :all_blank

  has_many :monthly_bills

  after_create :mark_room_occupied
  after_destroy :mark_room_vacant_if_empty

  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  private

  def mark_room_occupied
    house_room.update(status: :occupied) if house_room.vacant?
  end

  def mark_room_vacant_if_empty
    if house_room.tenants.count.zero?
      house_room.update(status: :vacant)
    end
  end
end
