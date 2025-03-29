require "test_helper"

class CreatureControllerTest < ActionDispatch::IntegrationTest
  test "should get add_combatant" do
    get creature_add_combatant_url
    assert_response :success
  end

  test "should get mark_dead" do
    get creature_mark_dead_url
    assert_response :success
  end

  test "should get restore_combatant" do
    get creature_restore_combatant_url
    assert_response :success
  end
end
