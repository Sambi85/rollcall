require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  test "is valid with valid attributes" do
    ability = Ability.new(name: "Storm King's Fireball", usage_type: "unlimited")
    assert ability.valid?
  end

  test "is invalid without a name" do
    ability = Ability.new(name: nil)
    assert_not ability.valid?
    assert_includes ability.errors[:name], "can't be blank"
  end

  test "is invalid with an invalid usage_type" do
    ability = Ability.new(name: "Blink", usage_type: "once")
    assert_not ability.valid?
    assert_includes ability.errors[:usage_type], "is not included in the list"
  end

  test "is valid when usage_type is nil" do
    ability = Ability.new(name: "Blink", usage_type: nil)
    assert ability.valid? == false 
  end
end
