class ChangeTurnOrderToText < ActiveRecord::Migration[8.0]
  def up
    remove_column :trackers, :turn_order if column_exists?(:trackers, :turn_order)
    add_column :trackers, :turn_order, :text, default: "--- []" # YAML empty array
  end

  def down
    remove_column :trackers, :turn_order if column_exists?(:trackers, :turn_order)
    add_column :trackers, :turn_order, :integer # Reverting to single integer if rolled back
  end
end
