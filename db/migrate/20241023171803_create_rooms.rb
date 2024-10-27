class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :uuid
      t.string :shared_link
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
