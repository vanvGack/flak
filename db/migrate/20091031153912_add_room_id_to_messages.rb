class AddRoomIdToMessages < ActiveRecord::Migration

  def self.up
    add_column :messages, :room_id, :integer
  end

  def self.down
    remove_column :messages, :room_id
  end

end
