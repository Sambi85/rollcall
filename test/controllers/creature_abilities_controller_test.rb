require "test_helper"

class CreatureAbilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @creature_ability = creature_abilities(:goblin_fireball_1)
    @creature = creatures(:goblin)
    @ability = abilities(:ice_dagger)
  end

  test "should get index" do
    get creature_abilities_url
    assert_response :success
  end

  test "should get new" do
    get new_creature_ability_url
    assert_response :success
  end

  test "should create creature_ability" do
    assert_difference("CreatureAbility.count") do
      post creature_abilities_url, params: { creature_ability: { ability_id: @ability.id, cooldown_rounds: 4, creature_id: @creature.id, notes: "test", usage_limit: 1 } }
    end

    assert_redirected_to creature_ability_url(CreatureAbility.last)
  end

  test "should show creature_ability" do
    get creature_ability_url(@creature_ability)
    assert_response :success
  end

  test "should get edit" do
    get edit_creature_ability_url(@creature_ability)
    assert_response :success
  end

  test "should update creature_ability" do
    patch creature_ability_url(@creature_ability), params: { creature_ability: { ability_id: @creature_ability.ability_id, cooldown_rounds: @creature_ability.cooldown_rounds, creature_id: @creature_ability.creature_id, notes: @creature_ability.notes, usage_limit: @creature_ability.usage_limit } }
    assert_redirected_to creature_ability_url(@creature_ability)
  end

  test "should destroy creature_ability" do
    assert_difference("CreatureAbility.count", -1) do
      delete creature_ability_url(@creature_ability)
    end

    assert_redirected_to creature_abilities_url
  end
end
