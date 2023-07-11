class AddForeignKeyConstraintToRoomUrls < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :room_urls, :events
  end
end
