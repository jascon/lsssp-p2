class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.integer :role_id,:null=>false
      t.string :name,:null=>false,:limit=>100
      t.string :last_name, :limit=>100
      t.string :enrollment_no
      t.string :primary_number
      t.string :secondary_number
      t.integer :credits,:default=>0
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      # t.encryptable
       t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
      t.boolean :approved ,:default=>false
#      t.boolean :rol_flag,:default=>false

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
