class AddProviderAttributes < ActiveRecord::Migration
  def self.up
    change_table :providers do |t|
      t.boolean  :dynamic, default: false
      t.datetime :expires_at
    end
  end

  def self.down
  end
end
