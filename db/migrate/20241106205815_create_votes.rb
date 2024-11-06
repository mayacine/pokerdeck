class CreateVotes < ActiveRecord::Migration[8.0]
  def change
    create_table :votes do |t|
      t.references :contributor, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.integer :estimation
      t.integer :status

      t.timestamps
    end
  end
end
