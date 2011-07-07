class CreateCertificateProviders < ActiveRecord::Migration
  def self.up
    create_table :certificate_providers do |t|
      t.integer :user_id,:null=>false
      t.integer :certification_id ,:null=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :certificate_providers
  end
end
