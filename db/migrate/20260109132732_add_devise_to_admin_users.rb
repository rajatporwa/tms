class AddDeviseToAdminUsers < ActiveRecord::Migration[7.0]
  def up
    change_table :admin_users do |t|
      ## Database authenticatable
      # t.string :email,              null: false, default: "" # Already exists
      # t.string :encrypted_password, null: false, default: "" # Check if exists
      
      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable (optional - uncomment if needed)
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip
    end

    # add_index :admin_users, :email, unique: true # Already exists
    add_index :admin_users, :reset_password_token, unique: true
  end

  def down
    # Remove added columns only
    remove_column :admin_users, :reset_password_token
    remove_column :admin_users, :reset_password_sent_at
    remove_column :admin_users, :remember_created_at
  end
end