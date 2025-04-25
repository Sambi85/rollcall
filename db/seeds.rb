# Clear existing data
Tracker.destroy_all
Creature.destroy_all
Effect.destroy_all

# Create Tracker (Global)
tracker = Tracker.create!(round: 1, turn_order: [])

# Create Effect (Global)
effect1 = Effect.create!(
  name: "Chill Wind",
  description: "A cold gust that slows enemies.",
  duration: 3,
  status_type: "debuff"
)

effect2 = Effect.create!(
  name: "Hero's Blessing",
  description: "Increases strength and morale.",
  duration: 5,
  status_type: "buff"
)

effect3 = Effect.create!(
  name: "Lingering Poison",
  description: "Deals damage over time.",
  duration: 4,
  status_type: "debuff"
)

# Create Creatures (Global)
creatures = [
  { name: "Aragorn", role: "player", initiative: rand(1..20), dead: false, current_hp: 15 , max_hp: 15 , temp_hp: 0 },
  { name: "Gandalf", role: "player", initiative: rand(1..20), dead: false, current_hp: 12 , max_hp: 12 , temp_hp: 0 },
  { name: "Goblin", role: "monster", initiative: rand(1..20), dead: false, current_hp: 8 , max_hp: 8 , temp_hp: 0 },
  { name: "The Pale Orc", role: "monster", initiative: rand(1..20), dead: false, current_hp: 25 , max_hp: 25 , temp_hp: 0 },
  { name: "Villager of Bywater", role: "npc", initiative: rand(1..20), dead: false, current_hp: 35 , max_hp: 35 , temp_hp: 0 }
]

# Save creatures and add their IDs to the tracker's turn order
creatures.each do |creature_data|
  creature = Creature.create!(creature_data.merge(tracker: tracker))
  tracker.turn_order << creature.id
end

# Sort initiative order
tracker.sort_turn_order
tracker.save!

puts "Seeded creature(s): #{Creature.count}, tracker(s): #{Tracker.count}, effect(s): #{Effect.count}!"
