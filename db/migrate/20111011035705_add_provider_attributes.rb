class AddProviderAttributes < ActiveRecord::Migration
  def self.up
    change_table :providers do |t|
      t.boolean  :dynamic, default: false
      t.datetime :expires_at
    end
    rename_column :providers, :check_session_endpoint, :check_id_endpoint
  end

  def self.down
  end
end
