class AddLanguageFkeyToPastes < ActiveRecord::Migration
  def self.up
    add_column :pastes, :language_id, :integer
    add_index :pastes, :language_id
  end

  def self.down
    remove_column :pastes, :language_id
  end
end
