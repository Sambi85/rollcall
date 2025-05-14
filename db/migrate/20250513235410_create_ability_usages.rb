class CreateAbilityUsages < ActiveRecord::Migration[8.0]
  def up
    create_table :ability_usages do |t|
      t.references :tracker, null: false, foreign_key: true
      t.references :creature, null: false, foreign_key: true
      t.references :ability, null: false, foreign_key: true
      t.datetime :used_at
      t.integer :round_used, default: 0
      t.integer :cooldown_remaining, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :ability_usages
  end
end
