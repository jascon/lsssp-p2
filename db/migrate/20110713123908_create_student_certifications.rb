class CreateStudentCertifications < ActiveRecord::Migration
  def self.up
    create_table :student_certifications do |t|
      t.integer :user_id ,:null=>false
      t.integer :certificate_provider_id,:null=>false
      t.integer :certification_id,:null=>false
      t.timestamps
    end
    add_index :student_certifications, [:certification_id,:user_id],:unique => true
  end

  def self.down
    drop_table :student_certifications
  end
end
