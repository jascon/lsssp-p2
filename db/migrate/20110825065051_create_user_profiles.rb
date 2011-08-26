class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.integer :user_id
      t.string  :father_name
      t.date    :dob
      t.string  :gender
      t.string  :address
      t.string  :address_one
      t.string  :address_two
      t.string  :zip
      t.string  :state
      t.string  :country
      t.string  :mobile
      t.string  :telephone
      t.text    :remarks

      t.string  :avatar_file_name
      t.string  :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
