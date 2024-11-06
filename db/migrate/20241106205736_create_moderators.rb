class CreateModerators < ActiveRecord::Migration[8.0]
  def change
    create_table :moderators do |t|
      t.string :name
      t.string :team_name
      t.string :current_room_uuid

      t.timestamps
    end
  end
end
