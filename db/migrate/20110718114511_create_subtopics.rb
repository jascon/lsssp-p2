class CreateSubtopics < ActiveRecord::Migration
  def self.up
    create_table :subtopics do |t|
      t.integer :topic_id  ,:null=>false
      t.string :name ,:null=>false ,:limit=>50
      t.boolean :active,:default=>0
      t.timestamps
    end
    add_index :subtopics, :name,:unique => true
  end

  def self.down
    drop_table :subtopics
  end
end
