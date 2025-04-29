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
  4. Special Event (Die of Doom)

**More on Tracker Class**
  - tracks of round (counter)
  - tracks current turn (first element in array)
  - tracks initative order (array)
  - Sorts initiative order by initative roll
  - adds combantants to intitative order
  - Marks active turn in initative order

**More on Creature Class**
  - tracks name
  - role (player, NPC, or monster)
  - initative roll
  - dead attr + methods to kill creature
  - tracks hit points, temp hit points and max hp
  - tracks death save successes and failures
  - resets death saves 
  - tracks tracker it belongs to

**More on Effect Class**
  - tracks name of effect
  - tracks type (buff, debuff, neutral)
  - tracks duration
  - has a description
  - tracks creature it belongs to

**More on Special Events Class**
- tracks name
- tracks description
- tracks frequency
- tracks tracker it belongs to

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

curl -X PUT "http://localhost:3000/trackers/:tracker_id/creatures/:creature_id/receive_damage" \
     -H "Content-Type: application/json" \
     -d '{"amount": 5}'

curl -X PUT "http://localhost:3000/trackers/:tracker_id/creatures/:creature_id/heal" \
     -H "Content-Type: application/json" \
     -d '{"amount": 3}'

curl -X PUT http://localhost:3000/trackers/:tracker_id/creatures/:creature_id/reset_death_saves

curl -X PUT http://localhost:3000/trackers/:tracker_id/creatures/:creature_id/add_death_save \
  -d "success=<SET AS TRUE OR FALSE!!!>"

```
Effects Controller
```bash
curl http://localhost:3000/effects

curl http://localhost:3000/effects/:effect_id

curl -X DELETE http://localhost:3000/effects/:effect_id

curl -X POST http://localhost:3000/effects \
  -H "Content-Type: application/json" \
  -d '{
    "effect": {
      "name": "Invisible",
      "duration":0,
      "description": "Cannot be seen.",
      "status_type": "buff"
    }
  }'

  curl -X POST http://localhost:3000/trackers/:id/creatures/:creature_id/effects \
  -H "Content-Type: application/json" \
  -d '{
    "effect": {
      "name": "Frightened",
      "description": "Disadvantage on attacks",
      "duration": 3,
      "status_type": "debuff"
    }
  }'

  curl -X PATCH http://localhost:3000/effects/:effect_id \
  -H "Content-Type: application/json" \
  -d '{
    "effect": {
      "creature_id": 5
    }
  }'
```

Creature Effects Controller - used to manage effects during combat
```bash
curl http://localhost:3000/trackers/:tracker_id/creatures/:creature_id/effects

curl -X DELETE http://localhost:3000/trackers/1/creatures/5/effects/12

curl -X POST http://localhost:3000/trackers/:tracker_id/creatures/:creature_id/effects \
  -H "Content-Type: application/json" \
  -d '{
    "effect": {
      "name": "Blinded",
      "description": "Cannot see, auto-fail vision-based checks",
      "duration": 2,
      "status_type": "debuff"
    }
  }'

curl -X PATCH http://localhost:3000/trackers/:tracker_id/creatures/:creature_id/effects/:effect_id \
  -H "Content-Type: application/json" \
  -d '{
    "effect": {
      "duration": 1
    }
  }'
```

**Todo**
  - Special Abilities worth tracking (Multi attack, 15ft. reach, etc.)
  - Add Enemies on the fly (new controller, tests, fixtures)
  - Allow trackers to have a name attr
  - Dry out test suite, use more fixtures
  - Apply up + down methods to migrations
  - model validations vs. migrations
  - External Facing API
  - Make CSV Import for easy combat setup
  - Make CSV Log Export for useful post combat data
  - Make readme for CSV Import/Export