class CreateTrackers < ActiveRecord::Migration[8.0]
  def change
    create_table :trackers do |t|
      t.integer :round
      t.text :turn_order

      t.timestamps
    end
  end
end
