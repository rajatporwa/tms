class TenantPartner < ApplicationRecord
  belongs_to :tenant

  has_one_attached :profile_photo
  has_one_attached :document_file
end
