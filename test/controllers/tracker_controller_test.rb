require "test_helper"

class TrackerControllerTest < ActionDispatch::IntegrationTest
  test "should get next_round" do
    get tracker_next_round_url
    assert_response :success
  end

  test "should get get_initiative_order" do
    get tracker_get_initiative_order_url
    assert_response :success
  end

  test "should get get_dead_combatants" do
    get tracker_get_dead_combatants_url
    assert_response :success
  end
end
