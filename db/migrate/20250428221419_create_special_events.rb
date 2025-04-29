class CreateSpecialEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :special_events do |t|
      t.string :name
      t.text :description
      t.integer :frequency
      t.references :tracker, foreign_key: true, null: true

      t.timestamps
    end
  end
end
