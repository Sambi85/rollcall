class CreateCreatureAbilities < ActiveRecord::Migration[8.0]
  def up
    create_table :creature_abilities do |t|
      t.references :creature, null: false, foreign_key: true
      t.references :ability, null: false, foreign_key: true
      t.integer :usage_limit, default: 0
      t.integer :cooldown_rounds, default: 0
      t.text :notes

      t.timestamps
    end
  end

  def down
    drop_table :creature_abilities
  end
end