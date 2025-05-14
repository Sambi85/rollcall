# === Clear existing data ===
[ AbilityUsage, CreatureAbility, Tracker, Creature, Effect, SpecialEvent, Ability ].each(&:destroy_all)

# === Create Tracker ===
tracker = Tracker.create!(round: 1, turn_order: [])

# === Effects ===
effects_data = [
  { name: "Chill Wind", description: "A cold gust that slows enemies.", duration: 3, status_type: "debuff" },
  { name: "Hero's Blessing", description: "Increases strength and morale.", duration: 5, status_type: "buff" },
  { name: "Lingering Poison", description: "Deals damage over time.", duration: 4, status_type: "debuff" }
]
Effect.create!(effects_data)

# === Special Events ===
SpecialEvent.create!(name: "Blizzard", description: "Bone chilling winds and heavy snow", frequency: 30)
SpecialEvent.create!(name: "Toxic Mist", description: "Poison Mist, Con save DC 11", frequency: 15, tracker: tracker)

# === Abilities ===
abilities = Ability.create!([
  { name: "Fireball", description: "Deals fire damage to all enemies in a small area.", usage_type: "limited", default_usage_limit: 3, default_cooldown: 0 },
  { name: "Heal", description: "Restores health to an ally.", usage_type: "cooldown", default_usage_limit: 0, default_cooldown: 2 },
  { name: "Berserk", description: "Increase attack power but lose some defense.", usage_type: "unlimited", default_usage_limit: 0, default_cooldown: 0 }
])
abilities_by_name = abilities.index_by(&:name)

# === Creatures ===
creature_data = [
  { name: "Aragorn", role: "player", max_hp: 15 },
  { name: "Gandalf", role: "player", max_hp: 12 },
  { name: "Goblin", role: "monster", max_hp: 8 },
  { name: "The Pale Orc", role: "monster", max_hp: 25 },
  { name: "Villager of Bywater", role: "npc", max_hp: 35 }
]

creatures = creature_data.map do |data|
  creature = Creature.create!(
    data.merge(
      tracker: tracker,
      current_hp: data[:max_hp],
      temp_hp: 0,
      initiative: rand(1..20),
      dead: false
    )
  )
  tracker.turn_order << creature.id
  creature
end
creatures_by_name = creatures.index_by(&:name)

# === CreatureAbilities ===
CreatureAbility.create!([
  {
    creature: creatures_by_name["Aragorn"],
    ability: abilities_by_name["Fireball"],
    usage_limit: 3,
    cooldown_rounds: 0,
    notes: "Learned from a scroll"
  },
  {
    creature: creatures_by_name["Gandalf"],
    ability: abilities_by_name["Heal"],
    usage_limit: 0,
    cooldown_rounds: 2,
    notes: "Can only be used once every few rounds"
  },
  {
    creature: creatures_by_name["Gandalf"],
    ability: abilities_by_name["Fireball"],
    usage_limit: 3,
    cooldown_rounds: 1,
    notes: "Cast with staff"
  },
  {
    creature: creatures_by_name["Goblin"],
    ability: abilities_by_name["Berserk"],
    usage_limit: 0,
    cooldown_rounds: 0,
    notes: "Innate rage"
  }
])

# === AbilityUsages ===
now = Time.current
AbilityUsage.create!([
  {
    tracker: tracker,
    creature: creatures_by_name["Aragorn"],
    ability: abilities_by_name["Fireball"],
    used_at: now - 1.minute,
    round_used: 1,
    cooldown_remaining: 0
  },
  {
    tracker: tracker,
    creature: creatures_by_name["Gandalf"],
    ability: abilities_by_name["Heal"],
    used_at: now - 30.seconds,
    round_used: 1,
    cooldown_remaining: 2
  },
  {
    tracker: tracker,
    creature: creatures_by_name["Goblin"],
    ability: abilities_by_name["Berserk"],
    used_at: now,
    round_used: 1,
    cooldown_remaining: 0
  }
])

# === Finalize tracker turn order ===
tracker.sort_turn_order
tracker.save!

puts "Seeded creature(s): #{Creature.count},
tracker(s): #{Tracker.count},
effect(s): #{Effect.count},
special event(s): #{SpecialEvent.count},
abilities: #{Ability.count},
creature_abilities: #{CreatureAbility.count},
ability_usages: #{AbilityUsage.count}!"
