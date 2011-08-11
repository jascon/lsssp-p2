class CreateCertificateProviders < ActiveRecord::Migration
  def self.up
    create_table :certificate_providers do |t|
      t.integer :provider_id,:null=>false
      t.integer :certification_id ,:null=>false
      t.timestamps
    end
    add_index :certificate_providers,[:provider_id,:certification_id],:unique=>true
  end

  def self.down
    drop_table :certificate_providers
  end
end
