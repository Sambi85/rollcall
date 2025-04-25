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

  test "should apply damage using receive_damage" do
    put tracker_creature_receive_damage_path(@tracker, @creature), params: { amount: 8 }, as: :json
    assert_response :success
    @creature.reload
    assert_equal 0, @creature.temp_hp
    assert_equal 2, @creature.current_hp
  end

  test "should not reduce hp below 0 with receive_damage" do
    put tracker_creature_receive_damage_path(@tracker, @creature), params: { amount: 50 }, as: :json
    assert_response :success
    @creature.reload
    assert_equal 0, @creature.current_hp
    assert @creature.dead
  end

  test "should heal creature and not exceed max_hp" do
    @creature.update!(current_hp: 1)
    put tracker_creature_heal_path(@tracker, @creature), params: { amount: 15 }, as: :json
    assert_response :success
    @creature.reload
    assert_equal 10, @creature.current_hp
  end

  test "should not heal dead creature" do
    @creature.update!(dead: true, current_hp: 0)
    put tracker_creature_heal_path(@tracker, @creature), params: { amount: 5 }, as: :json
    assert_response :success
    @creature.reload
    assert_equal 0, @creature.current_hp
  end
end
