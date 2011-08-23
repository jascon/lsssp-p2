class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :certification_id ,:null=>false
      t.integer :user_id,:null=>false
      t.string :name,:null=>false ,:limit=>50
      t.text :description
      t.timestamps
    end
    add_index :assignments,[:user_id,:certification_id,:name],:unique=>true
  end

  def self.down
    drop_table :assignments
  end
end
