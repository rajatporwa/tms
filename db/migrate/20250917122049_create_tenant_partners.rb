class CreateTenantPartners < ActiveRecord::Migration[7.2]
  def change
    create_table :tenant_partners do |t|
      t.references :tenant, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.string :gender
      t.string :father_name
      t.string :mother_name
      t.string :father_contact
      t.string :mother_contact
      t.string :mobile
      t.string :alternate_mobile
      t.text :before_rent_address
      t.text :permanent_address
      t.string :postal_code
      t.string :district
      t.string :state
      t.string :country
      t.string :occupation
      t.string :occupation_contact
      t.text :occupation_address
      t.string :document_type
      t.string :document_number
      t.string :document_file
      t.string :profile_photo
      t.string :vehicle_no
      t.integer :no_of_partners
      t.date :rent_start_date
      t.date :rent_end_date
      t.string :status

      t.timestamps
    end
  end
end
