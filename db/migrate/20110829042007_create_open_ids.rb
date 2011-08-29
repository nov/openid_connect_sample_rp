class CreateOpenIds < ActiveRecord::Migration
  def self.up
    create_table :open_ids do |t|
      t.belongs_to :account
      t.string :identifier, :access_token
      t.string :id_token, limit: 1024
      t.timestamps
    end
    add_index :open_ids, :identifier, unique: true
  end

  def self.down
    drop_table :open_ids
  end
end
