class CreatePastes < ActiveRecord::Migration
  def self.up
    create_table :pastes do |t|
      t.integer :user_id
      t.text :code, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :pastes
  end
end
