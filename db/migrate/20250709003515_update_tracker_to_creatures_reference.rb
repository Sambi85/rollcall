class UpdateTrackerToCreaturesReference < ActiveRecord::Migration[8.0]
  def up
    change_column_null :creatures, :tracker_id, true
  end

  def down
    change_column_null :creatures, :tracker_id, false
  end
end
