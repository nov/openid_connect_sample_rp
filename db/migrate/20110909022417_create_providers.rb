class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.belongs_to :account
      t.string :issuer, :jwks_uri, :name, :identifier, :secret, :scopes_supported, :host, :scheme
      t.string :authorization_endpoint, :token_endpoint, :userinfo_endpoint
      t.boolean :dynamic, default: false
      t.datetime :expires_at
      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end
