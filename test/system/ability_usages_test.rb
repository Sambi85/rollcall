require "application_system_test_case"

class AbilityUsagesTest < ApplicationSystemTestCase
  setup do
    @ability_usage = ability_usages(:one)
  end

  test "visiting the index" do
    visit ability_usages_url
    assert_selector "h1", text: "Ability usages"
  end

  test "should create ability usage" do
    visit ability_usages_url
    click_on "New ability usage"

    fill_in "Ability", with: @ability_usage.ability_id
    fill_in "Cooldown remaining", with: @ability_usage.cooldown_remaining
    fill_in "Creature", with: @ability_usage.creature_id
    fill_in "Round used", with: @ability_usage.round_used
    fill_in "Tracker", with: @ability_usage.tracker_id
    fill_in "Used at", with: @ability_usage.used_at
    click_on "Create Ability usage"

    assert_text "Ability usage was successfully created"
    click_on "Back"
  end

  test "should update Ability usage" do
    visit ability_usage_url(@ability_usage)
    click_on "Edit this ability usage", match: :first

    fill_in "Ability", with: @ability_usage.ability_id
    fill_in "Cooldown remaining", with: @ability_usage.cooldown_remaining
    fill_in "Creature", with: @ability_usage.creature_id
    fill_in "Round used", with: @ability_usage.round_used
    fill_in "Tracker", with: @ability_usage.tracker_id
    fill_in "Used at", with: @ability_usage.used_at.to_s
    click_on "Update Ability usage"

    assert_text "Ability usage was successfully updated"
    click_on "Back"
  end

  test "should destroy Ability usage" do
    visit ability_usage_url(@ability_usage)
    click_on "Destroy this ability usage", match: :first

    assert_text "Ability usage was successfully destroyed"
  end
end
