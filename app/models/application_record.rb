class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(auth_object = nil)
    # Get all column names except sensitive ones
    column_names - ['encrypted_password', 'password_digest', 'reset_password_token', 
                    'confirmation_token', 'unlock_token', 'authentication_token']
  end

  def self.ransackable_associations(auth_object = nil)
    # Allow searching through all associations
    reflect_on_all_associations.map(&:name).map(&:to_s)
  end
end
