require "test_helper"

class AbilityUsagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ability_usage = ability_usages(:goblin_fireball_1_usage)
  end

  test "should get index" do
    get ability_usages_url
    assert_response :success
  end

  test "should get new" do
    get new_ability_usage_url
    assert_response :success
  end

  test "should create ability_usage" do
    assert_difference("AbilityUsage.count") do
      post ability_usages_url, params: { ability_usage: { ability_id: @ability_usage.ability_id, cooldown_remaining: @ability_usage.cooldown_remaining, creature_id: @ability_usage.creature_id, round_used: @ability_usage.round_used, tracker_id: @ability_usage.tracker_id, used_at: @ability_usage.used_at } }
    end

    assert_redirected_to ability_usage_url(AbilityUsage.last)
  end

  test "should show ability_usage" do
    get ability_usage_url(@ability_usage)
    assert_response :success
  end

  test "should get edit" do
    get edit_ability_usage_url(@ability_usage)
    assert_response :success
  end

  test "should update ability_usage" do
    patch ability_usage_url(@ability_usage), params: { ability_usage: { ability_id: @ability_usage.ability_id, cooldown_remaining: @ability_usage.cooldown_remaining, creature_id: @ability_usage.creature_id, round_used: @ability_usage.round_used, tracker_id: @ability_usage.tracker_id, used_at: @ability_usage.used_at } }
    assert_redirected_to ability_usage_url(@ability_usage)
  end

  test "should destroy ability_usage" do
    assert_difference("AbilityUsage.count", -1) do
      delete ability_usage_url(@ability_usage)
    end

    assert_redirected_to ability_usages_url
  end
end
