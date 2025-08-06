class TrackersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tracker = trackers(:one)
    @creature = creatures(:goblin)
  end

  test "should get next_round" do
    put next_round_tracker_path(@tracker)
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
