class AddHpToCreatures < ActiveRecord::Migration[8.0]
  def up
    add_column :creatures, :current_hp, :integer, null: false, default: 0
    add_column :creatures, :max_hp, :integer, null: false, default: 0
    add_column :creatures, :temp_hp, :integer, null: false, default: 0
  end

  def down
    remove_column :creatures, :current_hp
    remove_column :creatures, :max_hp
    remove_column :creatures, :temp_hp
  end
end
