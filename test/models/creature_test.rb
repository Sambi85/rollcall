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

  test "kill method should mark creature as dead" do
    @creature.kill
    assert @creature.dead
  end
end
