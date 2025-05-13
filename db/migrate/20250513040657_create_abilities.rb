class CreateAbilities < ActiveRecord::Migration[8.0]
  def up
    create_table :abilities do |t|
      t.string :name
      t.text :description
      t.string :usage_type
      t.integer :default_usage_limit
      t.integer :default_cooldown

      t.timestamps
    end
  end

  def down
    drop_table :abilities
  end
end
