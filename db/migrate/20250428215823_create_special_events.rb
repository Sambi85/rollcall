class CreateSpecialEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :special_events do |t|
      t.string :name
      t.text :description
      t.integer :frequency
      t.integer :tracker_id

      t.timestamps
    end
  end
end
