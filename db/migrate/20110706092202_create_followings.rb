class CreateFollowings < ActiveRecord::Migration
  def self.up
    create_table :followings do |t|
      t.integer :user_id
      t.integer :follower_id
      t.timestamps
    end
    add_index :followings,:user_id
    add_index :followings,:follower_id
  end

  def self.down
    drop_table :followings
  end
end
