# Rollcall - Curl Testing
- Use these helpful curl commands for testing

**Trackers**
```bash
curl -X GET http://localhost:3000/trackers/:id/get_initiative_order
curl -X GET http://localhost:3000/trackers/:id/get_dead_combatants
curl -X PUT http://localhost:3000/trackers/:id/next_round
```
**Creatures**
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
**Effects Controller**
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

**Creature Effects (During Combat...)**
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
**Special Events**
```bash
curl -X GET http://localhost:3000/special_events
curl -X GET http://localhost:3000/special_events/:special_event_id
curl -X DELETE http://localhost:3000/special_events/:special_event_id

curl -X POST http://localhost:3000/special_events \
  -H "Content-Type: application/json" \
  -d '{
    "special_event": {
      "name": "Solar Flare",
      "description": "A massive flare affects all combatants.",
      "frequency": 1,
      "tracker_id": null
    }
  }'

curl -X PUT http://localhost:3000/special_events/:special_event_id \
  -H "Content-Type: application/json" \
  -d '{
    "special_event": {
      "name": "Updated Event Name",
      "description": "New description here.",
      "frequency": 2
    }
  }'
```

**Abilities**
```bash
curl http://localhost:3000/abilities
curl http://localhost:3000/abilities/:ability_id

curl -X POST http://localhost:3000/abilities \
  -H "Content-Type: application/json" \
  -d '{"ability": {"name": "Fireball", "usage_type": "limited"}}'

curl -X PUT http://localhost:3000/abilities/:ability_id \
  -H "Content-Type: application/json" \
  -d '{"ability": {"name": "Ice Blast"}}'

curl -X DELETE http://localhost:3000/abilities/:ability_id
```
**CreatureAbilities**
- WIP
**AbilitiesUsages**
- WIP