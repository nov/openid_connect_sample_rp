class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.belongs_to :account
      t.string :name, :identifier, :secret, :scope, :host, :scheme
      t.string :authorization_endpoint, :token_endpoint, :check_session_endpoint, :user_info_endpoint
      t.timestamps
    end
  end

  def self.down
    drop_table :providers
  end
end
