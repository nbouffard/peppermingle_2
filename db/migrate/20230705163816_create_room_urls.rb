class CreateRoomUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :room_urls do |t|
      t.string :url
      t.integer :event_id

      t.timestamps
    end
  end
end
