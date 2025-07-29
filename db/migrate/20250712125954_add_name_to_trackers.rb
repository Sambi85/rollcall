class AddNameToTrackers < ActiveRecord::Migration[7.0]
  def up
    add_column :trackers, :name, :string
  end

  def down
    remove_column :trackers, :name
  end
end
