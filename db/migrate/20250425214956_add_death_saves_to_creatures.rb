class AddDeathSavesToCreatures < ActiveRecord::Migration[8.0]
  def up
    add_column :creatures, :death_saves_successes, :integer, null: false, default: 0
    add_column :creatures, :death_saves_failures, :integer, null: false, default: 0
  end

  def down
    remove_column :creatures, :death_saves_successes
    remove_column :creatures, :death_saves_failures
  end
end
