require "test_helper"
# Refactor, use fixtures instead

class AbilityUsageTest < ActiveSupport::TestCase
  def setup
    @tracker = Tracker.create!(round: 1)
    @creature = Creature.create!(name: "Goblin", tracker: @tracker)
    @ability = Ability.create!(name: "Fireball2", usage_type: "limited")
    @creature_ability = CreatureAbility.new(
      creature_id: @creature.id,
      ability_id: @ability.id,
      usage_limit: 2,
      cooldown_rounds: 1,
      notes: "Can only be used in melee"
    ).save!

    @usage = AbilityUsage.new(
      tracker: @tracker,
      creature: @creature,
      ability: @ability,
      used_at: Time.current,
      round_used: 2,
      cooldown_remaining: 1
    )
  end

  test "is valid with all required fields" do
    @creature_ability.save!
    @usage.save!
    assert @usage.valid?
  end

  test "is invalid without tracker" do
    @usage.tracker = nil
    assert_not @usage.valid?
  end

  test "is invalid without creature" do
    @usage.creature = nil
    assert_not @usage.valid?
  end

  test "is invalid without ability" do
    @usage.ability = nil
    assert_not @usage.valid?
  end

  test "defaults round_used to 0" do
    usage = AbilityUsage.new(tracker: @tracker, creature: @creature, ability: @ability)
    assert_equal 0, usage.round_used
  end

  test "defaults cooldown_remaining to 0" do
    usage = AbilityUsage.new(tracker: @tracker, creature: @creature, ability: @ability)
    assert_equal 0, usage.cooldown_remaining
  end
end
