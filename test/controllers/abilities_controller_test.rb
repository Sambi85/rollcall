require "test_helper"

class AbilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ability = abilities(:fireball)
  end

  test "should get index" do
    get abilities_url
    assert_response :success
  end

  test "should create ability" do
    assert_difference("Ability.count") do
      post abilities_url, params: {
        ability: {
          default_cooldown: 10,
          default_usage_limit: 2,
          description: 'test',
          name: 'Cloud Kill',
          usage_type: 'limited'
        }
      }, as: :json
    end
    assert_response :created
  end

  test "should show ability" do
    get ability_url(@ability)
    assert_response :success
  end

  test "should update ability" do
    patch ability_url(@ability), params: {
      ability: {
        default_cooldown: @ability.default_cooldown,
        default_usage_limit: @ability.default_usage_limit,
        description: @ability.description,
        name: @ability.name,
        usage_type: @ability.usage_type
      }
    }, as: :json

    assert_response :ok
  end

  test "should destroy ability" do
    assert_difference("Ability.count", -1) do
      delete ability_url(@ability), as: :json
    end

    assert_response :no_content
  end
end
