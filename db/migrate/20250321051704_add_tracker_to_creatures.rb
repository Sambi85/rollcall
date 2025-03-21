class AddTrackerToCreatures < ActiveRecord::Migration[8.0]
  def change
    add_reference :creatures, :tracker, null: false, foreign_key: true
  end
end
