class CreateEffects < ActiveRecord::Migration[8.0]
  def change
    create_table :effects do |t|
      t.string :name
      t.text :description
      t.integer :duration
      t.string :status_type
      t.references :creature, null: false, foreign_key: true

      t.timestamps
    end
  end
end
