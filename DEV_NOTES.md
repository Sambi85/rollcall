# Dev Notes

**What does it do?**
  - Tracks Initative order
  - Whose turn it is
  - What round we are on
  - toggle K.O.'d combatants
  - Tracks Effects on monsters, players, npcs
  - Tracks if Effects are perminant or ellasped

**Features**
  - Agnostic Initiative tracker for (dnd,pathfinder,etc.)
  - Add enemies or players to initative
  - Marks enemies or players as dead
  - Marks enemies or players as alive and adds back to initative order (keeps same order by default)
  - Create Effects and apply them to monsters, players and npcs
  - Track Effects durations each round

**Data Models**
  1. Tracker
  2. Creature
  3. Effect

**More on Tracker Class**
  - Keeps track of round => use a counter
  - order of Initative => use an Array
  - Sort turn order by initative roll
  - Marks active turn in initative order

**More on Creature Class**
  - tracks name
  - role => player, NPC, or monster
  - initative roll
  - dead attr + methods to kill creature

**More on Effect Class**
  - WIP

**Manual Testing with CURL commands**
Trackers Controller
```bash
curl -X GET http://localhost:3000/trackers/:id/get_initiative_order
curl -X GET http://localhost:3000/trackers/:id/get_dead_combatants
curl -X PUT http://localhost:3000/trackers/:id/next_round
```
Creatures Controller
```bash
curl -X POST http://localhost:3000/trackers/:id/creatures \
  -H "Content-Type: application/json" \
  -d '{"creature": {"name": "Goblin", "role": "Enemy", "initiative": 10, "tracker_id": 1 }}'

curl -X PUT http://localhost:3000/trackers/:id/creatures/:creature_id/mark_dead
curl -X PUT "http://localhost:3000/trackers/:id/creatures/:creature_id/mark_alive"
```
Effects Controller - WIP
```bash
```

**Todo**
  - HP tracking (CRU) 
  - Die of Doom tracker (Special Event)
  - External Facing API
  - Make CSV Import for easy combat setup
  - Make CSV Log Export for useful post combat data
  - Make readme for CSV Import/Export