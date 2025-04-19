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

  test "should initialize with empty turn_order by default" do
    tracker = Tracker.new
    assert_equal [], tracker.turn_order
  end

  test "should have many creatures" do
    assert_equal 2, @tracker.creatures.count
  end

  test "should handle tracker with no creatures" do
    empty_tracker = Tracker.create!(round: 1)
    assert_equal [], empty_tracker.turn_order
    assert_nothing_raised { empty_tracker.sort_turn_order }
  end

  test "should not crash when rotating empty turn_order" do
    @tracker.turn_order = []
    assert_nothing_raised do
      @tracker.mark_active_turn
    end
  end

  test "should allow duplicate creature IDs in turn_order" do
    creature = @creatures.first
    assert_equal 2, @tracker.turn_order.size
    assert_equal 1, @tracker.turn_order.count(creature.id)

    @tracker.add_combatant(creature)
    assert_equal 2, @tracker.turn_order.count(creature.id)
  end

  test "should add creature and sort turn_order" do
    new_creature = Creature.create!(name: "Mage", role: "player", initiative: 20, dead: false, tracker: @tracker)
    @tracker.turn_order = []
    @tracker.save!

    @tracker.add_combatant(new_creature)

    assert_includes @tracker.turn_order, new_creature.id
    assert_equal [ new_creature.id ], @tracker.turn_order
  end

  test "should rotate turn order and increment round" do
    original_order = @tracker.turn_order.dup
    original_round = @tracker.round

    @tracker.next_round

    assert_equal original_order.rotate, @tracker.turn_order
    assert_equal original_round + 1, @tracker.round
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
