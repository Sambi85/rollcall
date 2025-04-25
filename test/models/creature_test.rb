require "test_helper"

class CreatureTest < ActiveSupport::TestCase
  def setup
    @tracker = Tracker.create!(round: 1)
    @creature = creatures(:goblin)
    @fallen_paladin = creatures(:fallen_paladin)
    @dying_rouge = creatures(:dying_rouge)
    @damaged_creature = creatures(:damaged_imp)
    @buffed_creature = creatures(:buffed_devil)
  end

  test "should be valid with valid attributes" do
    assert @creature.valid?
  end

  test "should be invalid without a name" do
    creature = Creature.new(initiative: 10, dead: false, tracker: @tracker)
    assert_not creature.valid?
    assert_includes creature.errors[:name], "can't be blank"
  end

  test "#mark_dead method should mark creature as dead" do
    @creature.mark_dead
    assert @creature.dead
  end

  test "#mark_alive method should mark creature as alive" do
    @creature.mark_dead
    @creature.mark_alive
    assert_not @creature.dead
  end

  test "#down method should reduce current_hp and temp_hp" do
    @buffed_creature.down(3) # Reducing less than temp_hp
    assert_equal 2, @buffed_creature.temp_hp
    assert_equal 1, @buffed_creature.current_hp

    @buffed_creature.down(5) # Reducing more than temp_hp
    assert_equal 0, @buffed_creature.temp_hp
    assert_equal 0, @buffed_creature.current_hp

    @buffed_creature.down(10) # Reducing more than current_hp
    assert_equal 0, @buffed_creature.temp_hp
    assert_equal 0, @buffed_creature.current_hp
    assert @buffed_creature.dead # Creature should be marked dead
  end

  test "#up method should increase current_hp and not exceed max_hp" do
    @damaged_creature.up(5)
    assert_equal 6, @damaged_creature.current_hp # current_hp should be 15 after healing
    assert_not @damaged_creature.dead

    @damaged_creature.up(10)
    assert_equal 16, @damaged_creature.current_hp # current_hp should be capped at max_hp
    assert_not @damaged_creature.dead
  end

  test "#restore method should set current_hp to max_hp and reset temp_hp" do
    @damaged_creature.restore
    assert_equal 20, @damaged_creature.current_hp # current_hp should be restored to max_hp
    assert_equal 0, @damaged_creature.temp_hp # temp_hp should be reset to 0
    assert_not @damaged_creature.dead # Creature should still be alive
  end


  test "#mark_dead method should mark creature as dead when current_hp <= 0" do
    @creature.current_hp = 0
    @creature.mark_dead
    assert @creature.dead
  end

  test "#mark_alive method should mark creature as alive when called" do
    @creature.mark_dead
    @creature.mark_alive
    assert_not @creature.dead
  end

  test "#reset_death_saves sets successes and failures to zero" do
    @fallen_paladin.reset_death_saves

    assert_equal 0, @fallen_paladin.death_saves_successes
    assert_equal 0, @fallen_paladin.death_saves_failures
  end

  test "#add_death_save increments successes and sets dead to false at 3" do
    @dying_rouge.update!(death_saves_successes: 2, death_saves_failures: 0, dead: true)  
    @dying_rouge.add_death_save(success: true)
    @dying_rouge.reload
  
    assert_equal 3, @dying_rouge.death_saves_successes
    assert_equal false, @dying_rouge.dead
  end
  
  test "#add_death_save increments failures and sets dead to true at 3" do
    @dying_rouge.update!(death_saves_successes: 0, death_saves_failures: 2, dead: false) 
    @dying_rouge.add_death_save(success: false)
    @dying_rouge.reload
  
    assert_equal 3, @dying_rouge.death_saves_failures
    assert_equal true, @dying_rouge.dead
  end
  
  test "#add_death_save increments successes without changing dead under 3" do
    @dying_rouge.update!(death_saves_successes: 1, death_saves_failures: 0, dead: true)
    @dying_rouge.add_death_save(success: true)
    @dying_rouge.reload
  
    assert_equal 2, @dying_rouge.death_saves_successes
    assert_equal true, @dying_rouge.dead
  end
  
  test "#add_death_save increments failures without changing dead under 3" do
    @dying_rouge.update!(death_saves_successes: 0, death_saves_failures: 1, dead: false)
    @dying_rouge.add_death_save(success: false)
    @dying_rouge.reload
  
    assert_equal 2, @dying_rouge.death_saves_failures
    assert_equal false, @dying_rouge.dead
  end
end
