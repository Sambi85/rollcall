require "application_system_test_case"

class CreatureAbilitiesTest < ApplicationSystemTestCase
  setup do
    @creature_ability = creature_abilities(:one)
  end

  test "visiting the index" do
    visit creature_abilities_url
    assert_selector "h1", text: "Creature abilities"
  end

  test "should create creature ability" do
    visit creature_abilities_url
    click_on "New creature ability"

    fill_in "Ability", with: @creature_ability.ability_id
    fill_in "Cooldown rounds", with: @creature_ability.cooldown_rounds
    fill_in "Creature", with: @creature_ability.creature_id
    fill_in "Notes", with: @creature_ability.notes
    fill_in "Usage limit", with: @creature_ability.usage_limit
    click_on "Create Creature ability"

    assert_text "Creature ability was successfully created"
    click_on "Back"
  end

  test "should update Creature ability" do
    visit creature_ability_url(@creature_ability)
    click_on "Edit this creature ability", match: :first

    fill_in "Ability", with: @creature_ability.ability_id
    fill_in "Cooldown rounds", with: @creature_ability.cooldown_rounds
    fill_in "Creature", with: @creature_ability.creature_id
    fill_in "Notes", with: @creature_ability.notes
    fill_in "Usage limit", with: @creature_ability.usage_limit
    click_on "Update Creature ability"

    assert_text "Creature ability was successfully updated"
    click_on "Back"
  end

  test "should destroy Creature ability" do
    visit creature_ability_url(@creature_ability)
    click_on "Destroy this creature ability", match: :first

    assert_text "Creature ability was successfully destroyed"
  end
end
