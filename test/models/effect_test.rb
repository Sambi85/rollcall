require "test_helper"

class EffectTest < ActiveSupport::TestCase
  def setup
    @creature = creatures(:skeleton)
    @effect = effects(:three)
  end

  test "should be valid with valid attributes" do
    assert @effect.valid?
  end

  test "should be invalid without a name" do
    @effect.name = nil
    assert_not @effect.valid?
    assert_includes @effect.errors[:name], "can't be blank"
  end

  test "should be invalid if name is too long" do
    @effect.name = "A" * 101
    assert_not @effect.valid?
  end

  test "should allow optional description" do
    @effect.description = nil
    assert @effect.valid?
  end

  test "should be invalid if description is too long" do
    @effect.description = "B" * 501
    assert_not @effect.valid?
  end

  test "should allow nil duration" do
    @effect.duration = nil
    assert @effect.valid?
  end

  test "should be invalid if duration is negative" do
    @effect.duration = -1
    assert_not @effect.valid?
  end

  test "should be invalid if status_type is not allowed" do
    @effect.status_type = "mega-buff"
    assert_not @effect.valid?
  end

  test "expired? returns false if duration is nil" do
    @effect.duration = nil
    assert_not @effect.expired?
  end

  test "expired? returns false if duration > 0" do
    @effect.duration = 3
    assert_not @effect.expired?
  end

  test "expired? returns true if duration <= 0" do
    @effect.duration = 0
    assert @effect.expired?
  end

  test "should be valid without a creature (optional)" do
    @effect.creature = nil
    assert @effect.valid?
  end
end
