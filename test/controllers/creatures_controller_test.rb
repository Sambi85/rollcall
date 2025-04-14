require "test_helper"

class CreaturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tracker = trackers(:one)
    @tracker2 = trackers(:two)
    @creature = creatures(:goblin)
  end

  test "should add combatant to initiative tracker" do
    post tracker_creatures_path(@tracker2), params: {
      creature: {
          name: "Test Creature",
          role: "monster",
          initiative: 12
        }
      },
      as: :json,
      headers: {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }
    assert_response :success
  end

  test "should mark creature as dead" do
    put tracker_creature_mark_dead_path(@tracker, @creature)
    assert_response :success
  end

  test "should mark creature as alive" do
    put tracker_creature_mark_alive_path(@tracker, @creature)
    assert_response :success
  end
end
