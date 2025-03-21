require "test_helper"

class TrackerTest < ActiveSupport::TestCase
  def setup
    @tracker = Tracker.create!(round: 1, turn_order: [])
    @creatures = [
      Creature.create!(name: "Warrior", role: "player", initiative: 15, dead: false, tracker: @tracker),
      Creature.create!(name: "Goblin", role: "monster", initiative: 10, dead: false, tracker: @tracker)
    ]
    @tracker.turn_order = @creatures.map(&:id)
    @tracker.save!
  end

  test "should sort creatures by initiative in descending order" do
    @tracker.sort_turn_order
    sorted_ids = @creatures.sort_by(&:initiative).reverse.map(&:id)
    assert_equal sorted_ids, @tracker.turn_order
  end

  test "should rotate turn order" do
    first_id = @tracker.turn_order.first
    @tracker.mark_active_turn
    assert_not_equal first_id, @tracker.turn_order.first
  end
end
