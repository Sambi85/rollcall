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

  test "should reset death saves" do
    @creature.update!(death_saves_successes: 2, death_saves_failures: 1)

    put tracker_creature_reset_death_saves_path(@tracker, @creature), as: :json
    assert_response :success

    @creature.reload
    assert_equal 0, @creature.death_saves_successes
    assert_equal 0, @creature.death_saves_failures
  end

  test "should add successful death save" do
    @creature.update!(death_saves_successes: 1, death_saves_failures: 0, dead: true)

    put tracker_creature_add_death_save_path(@tracker, @creature), params: { success: true }, as: :json
    assert_response :success

    @creature.reload
    assert_equal 2, @creature.death_saves_successes
  end

  test "should add failed death save" do
    @creature.update!(death_saves_successes: 0, death_saves_failures: 2, dead: false)

    put tracker_creature_add_death_save_path(@tracker, @creature), params: { success: false }, as: :json
    assert_response :success

    @creature.reload
    assert_equal 3, @creature.death_saves_failures
    assert @creature.dead
  end

  test "should return error if success param missing in add_death_save" do
    put tracker_creature_add_death_save_path(@tracker, @creature), as: :json
    assert_response :unprocessable_entity
    body = JSON.parse(@response.body)
    assert_equal "Missing parameter: success", body["error"]
  end
end
