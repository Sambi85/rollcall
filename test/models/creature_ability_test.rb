require "test_helper"

class CreatureAbilityTest < ActiveSupport::TestCase
  def setup
    @creature = Creature.create!(name: "Orc")
    @ability = Ability.create!(name: "Rage", usage_type: "encounter")

    @creature_ability = CreatureAbility.new(
      creature: @creature,
      ability: @ability,
      usage_limit: 2,
      cooldown_rounds: 1,
      notes: "Can only be used in melee"
    )
  end

  test "is valid with all required fields" do
    assert @creature_ability.valid?
  end

  test "is invalid without creature" do
    @creature_ability.creature = nil
    assert_not @creature_ability.valid?
  end

  test "is invalid without ability" do
    @creature_ability.ability = nil
    assert_not @creature_ability.valid?
  end

  test "defaults usage_limit to 0" do
    ca = CreatureAbility.new(creature: @creature, ability: @ability)
    assert_equal 0, ca.usage_limit
  end

  test "defaults cooldown_rounds to 0" do
    ca = CreatureAbility.new(creature: @creature, ability: @ability)
    assert_equal 0, ca.cooldown_rounds
  end
end
