require "test_helper"

class EffectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tracker = Tracker.create!(round: 1)
    @creature = creatures(:zombie)
    @effect = effects(:four)
  end

  test "should get index" do
    get effects_url, as: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_kind_of Array, body
  end

  test "should show effect" do
    get effect_url(@effect), as: :json
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal @effect.name, body["name"]
  end

  test "should create effect" do
    assert_difference("Effect.count") do
      post effects_url, params: {
        effect: {
          name: "Cursed Mark",
          description: "Lingers and lowers defense.",
          duration: 2,
          status_type: "debuff",
          creature_id: @creature.id
        }
      }, as: :json
    end

    assert_response :created
    body = JSON.parse(response.body)
    assert_equal "Cursed Mark", body["name"]
  end

  test "should not create invalid effect" do
    assert_no_difference("Effect.count") do
      post effects_url, params: {
        effect: {
          name: "",
          status_type: "invalid"
        }
      }, as: :json
    end
  
    assert_response :unprocessable_entity
    body = JSON.parse(response.body)
    assert_includes body["errors"], "Name can't be blank"
    assert_includes body["errors"], "Status type is not included in the list"
  end
  

  test "should update effect" do
    patch effect_url(@effect), params: {
      effect: { duration: 1 }
    }, as: :json

    assert_response :success
    @effect.reload
    assert_equal 1, @effect.duration
  end

  test "should destroy effect" do
    assert_difference("Effect.count", -1) do
      delete effect_url(@effect), as: :json
    end

    assert_response :no_content
  end
end
