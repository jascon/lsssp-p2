class Someadditions < ActiveRecord::Migration
  def self.up
    add_column :questions, :question_file_name, :string # Original filename
    add_column :questions, :question_content_type, :string # Mime type
    add_column :questions, :question_file_size, :integer # File size in bytes

    add_column :answers, :answer_file_name, :string # Original filename
    add_column :answers, :answer_content_type, :string # Mime type
    add_column :answers, :answer_file_size, :integer # File size in bytes

  end

  def self.down
    remove_column :questions, :question_file_name
    remove_column :questions, :question_content_type
    remove_column :questions, :question_file_size

    remove_column :answers, :answer_file_name
    remove_column :answers, :answer_content_type
    remove_column :answers, :answer_file_size

  end
end
