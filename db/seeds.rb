# Clear existing data
Tracker.destroy_all
Creature.destroy_all

# Create a Tracker
tracker = Tracker.create!(round: 1, turn_order: [])

# Create Creatures
creatures = [
  { name: "Aragorn", role: "player", initiative: rand(1..20), dead: false },
  { name: "Gandalf", role: "player", initiative: rand(1..20), dead: false },
  { name: "Goblin", role: "monster", initiative: rand(1..20), dead: false },
  { name: "The Pale Orc", role: "monster", initiative: rand(1..20), dead: false },
  { name: "Villager of Bywater", role: "npc", initiative: rand(1..20), dead: false }
]

# Save creatures and add their IDs to the tracker's turn order
creatures.each do |creature_data|
  creature = Creature.create!(creature_data.merge(tracker: tracker))
  tracker.turn_order << creature.id
end

# Sort initiative order
tracker.sort_turn_order
tracker.save!

puts "Seeded #{Creature.count} creatures and 1 tracker!"