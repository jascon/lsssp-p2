class CreateStudentAssignments < ActiveRecord::Migration
  def self.up
    create_table :student_assignments do |t|
      t.integer :assignment_id ,:null=>false
      t.integer :owned_certification_id,:null=>false
      t.integer :assigner_id ,:null=>false
      t.text :description
      t.string :status ,:null=>false,:default=>'pending'
      t.timestamps
    end
    add_index :student_assignments ,[:owned_certification_id,:assignment_id],:unique=>true,:name=>'by_owned_and_assignment_id'
    add_index :student_assignments,:assigner_id
  end

  def self.down
    drop_table :student_assignments
  end
end
