require "test_helper"

class SpecialEventTest < ActiveSupport::TestCase
  def setup
    @valid_attributes = {
      name: "Test Event",
      description: "This is a test event.",
      frequency: 5
    }
  end

  test "is valid with valid attributes" do
    event = SpecialEvent.new(@valid_attributes)
    assert event.valid?
  end

  test "is invalid without a name" do
    event = SpecialEvent.new(@valid_attributes.merge(name: nil))
    assert_not event.valid?
    assert_includes event.errors[:name], "can't be blank"
  end

  test "is invalid with a name longer than 100 characters" do
    long_name = "a" * 101
    event = SpecialEvent.new(@valid_attributes.merge(name: long_name))
    assert_not event.valid?
    assert_includes event.errors[:name], "is too long (maximum is 100 characters)"
  end

  test "is invalid without a description" do
    event = SpecialEvent.new(@valid_attributes.merge(description: nil))
    assert_not event.valid?
    assert_includes event.errors[:description], "can't be blank"
  end

  test "is invalid with a description longer than 500 characters" do
    long_description = "a" * 501
    event = SpecialEvent.new(@valid_attributes.merge(description: long_description))
    assert_not event.valid?
    assert_includes event.errors[:description], "is too long (maximum is 500 characters)"
  end

  test "is invalid without a frequency" do
    event = SpecialEvent.new(@valid_attributes.merge(frequency: nil))
    assert_not event.valid?
    assert_includes event.errors[:frequency], "can't be blank"
  end

  test "is invalid with a frequency less than 1" do
    event = SpecialEvent.new(@valid_attributes.merge(frequency: 0))
    assert_not event.valid?
    assert_includes event.errors[:frequency], "must be greater than or equal to 1"
  end

  test "is invalid with a non-integer frequency" do
    event = SpecialEvent.new(@valid_attributes.merge(frequency: 2.5))
    assert_not event.valid?
    assert_includes event.errors[:frequency], "must be an integer"
  end

  test "can be associated with a tracker" do
    tracker = trackers(:one)
    event = SpecialEvent.new(@valid_attributes.merge(tracker: tracker))
    assert event.valid?
    assert_equal tracker, event.tracker
  end

  test "can exist without a tracker (global event)" do
    event = SpecialEvent.new(@valid_attributes)
    assert event.valid?
    assert_nil event.tracker
  end
end
