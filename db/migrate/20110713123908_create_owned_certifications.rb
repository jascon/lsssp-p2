class CreateOwnedCertifications < ActiveRecord::Migration
  def self.up
    create_table :owned_certifications do |t|
      t.integer :owned_id ,:null=>false
      t.integer :provider_id,:null=>false
      t.integer :certification_id,:null=>false
      t.decimal :amount ,:null=>false ,:precision => 10, :scale => 2
      t.boolean :issued,:default=>0
      t.boolean :student_assignments_status,:default=>0
      t.string :student_assignments_result,:default=>'processing',:null=>false
      t.integer :student_assignments_count ,:null=>false,:default=>0
      t.timestamps
    end
    add_index :owned_certifications, [:certification_id,:owned_id,:provider_id],:unique => true ,:name=>'by_certification_provider_owned'
  end

  def self.down
    drop_table :owned_certifications
  end
end
