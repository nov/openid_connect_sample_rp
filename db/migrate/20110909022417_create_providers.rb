class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.belongs_to :account
      t.string :issuer, :name, :identifier, :secret, :scope, :host, :scheme
      t.string :authorization_endpoint, :token_endpoint, :user_info_endpoint, :x509_url, :jwk_url
      t.boolean :dynamic, default: false
      t.datetime :expires_at
      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end
