require "test_helper"

class SpecialEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = special_events(:meteor_swarm)
  end

  test "should get index" do
    get special_events_url, as: :json
    assert_response :success
    body = JSON.parse(@response.body)
    assert_includes body.map { |e| e["id"] }, @event.id
  end

  test "should show special_event" do
    get special_event_url(@event), as: :json
    assert_response :success
    body = JSON.parse(@response.body)
    assert_equal @event.name, body["name"]
  end

  test "should create special_event" do
    assert_difference("SpecialEvent.count") do
      post special_events_url, params: {
        special_event: {
          name: "New Event",
          description: "A new global event",
          frequency: 5
        }
      }, as: :json
    end

    assert_response :created
  end

  test "should update special_event" do
    patch special_event_url(@event), params: {
      special_event: { frequency: 20 }
    }, as: :json

    assert_response :success
    @event.reload
    assert_equal 20, @event.frequency
  end

  test "should destroy special_event" do
    assert_difference("SpecialEvent.count", -1) do
      delete special_event_url(@event), as: :json
    end

    assert_response :no_content
  end
end
