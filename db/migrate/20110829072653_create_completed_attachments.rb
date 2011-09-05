class CreateCompletedAttachments < ActiveRecord::Migration
  def self.up
    create_table :completed_attachments do |t|
      t.integer :student_assignment_id ,:null=>false
      t.integer :attachment_id,:null=>false
      t.string :hanger_file_name
      t.string :hanger_content_type
      t.integer :hanger_file_size
      t.datetime :hanger_updated_at
      t.timestamps
    end
    add_index :completed_attachments,[:student_assignment_id,:attachment_id],:unique=>true,:name=>'student_assignment_attachment_id'
  end

  def self.down
    drop_table :completed_attachments
  end
end
