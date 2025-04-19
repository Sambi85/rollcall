require "test_helper"

class CreatureTest < ActiveSupport::TestCase
  def setup
    @tracker = Tracker.create!(round: 1)
    @creature = Creature.create!(name: "Goblin", role: "monster", initiative: 10, dead: false, tracker: @tracker)
  end

  test "should be valid with valid attributes" do
    assert @creature.valid?
  end

  test "should be invalid without a name" do
    creature = Creature.new(initiative: 10, dead: false, tracker: @tracker)
    assert_not creature.valid?
    assert_includes creature.errors[:name], "can't be blank"
  end

  test "mark_dead method should mark creature as dead" do
    @creature.mark_dead
    assert @creature.dead
  end

  test "mark_alive method should mark creature as alive" do
    @creature.mark_dead
    @creature.mark_alive
    assert_not @creature.dead
  end
end
