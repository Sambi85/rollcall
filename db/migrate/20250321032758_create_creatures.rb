class CreateCreatures < ActiveRecord::Migration[8.0]
  def change
    create_table :creatures do |t|
      t.string :name
      t.string :role
      t.integer :initiative
      t.boolean :dead

      t.timestamps
    end
  end
end
