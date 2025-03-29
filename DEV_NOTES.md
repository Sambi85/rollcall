# Dev Notes

**What does it do?**
  - Tracks Initative order
  - Whose turn it is
  - What round we are on
  - K.O.'d combatants

**Features**
  - Add enemies or players to initative
  - Marks enemies or players as dead
  - Restores enemies or players to initative order (keep the same order)

**Data Models**
  1. Tracker
  2. Creature

**More on Tracker Class**
  - Keeps track of round => use a counter
  - order of Initative => use an Array
  - Sort turn order by initative roll => method
  - Marks active turn in initative order =>

**More on Creature Class**
  - tracks name
  - role => player, NPC, or monster
  - initative roll
  - dead attr + methods to kill creature

**Manual Testing with CURL commands**
Trackers Controller
GET curl -X GET http://localhost:3000/trackers/:id/get_initiative_order
GET curl -X GET http://localhost:3000/trackers/:id/get_dead_combatants
POST curl -X POST http://localhost:3000/trackers/:id/next_round

Creatures Controller
POST curl -X POST http://localhost:3000/trackers/:id/creatures \
  -H "Content-Type: application/json" \
  -d '{"creature": {"name": "Goblin", "role": "Enemy", "initiative_roll": 10, "hp": 25}}'

!!! NEED mark_dead
!!! NEED restore_combatant

**Todo**
  - Status, Concentration and Conditions (CRUD)
  - HP tracking (CRU)
  - Die of Doom tracker
  - Make MVC backend w/ API
  - Make CSV Import for easy combat setup
  - Make CSV Log Export for useful post combat data
  - Make readme for CSV Import/Export