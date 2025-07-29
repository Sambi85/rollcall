# RollCall - Dev Notes

**What does it do?**
  - agnostic Initiative tracker for TTRPG games
  - tracks current Turn
  - tracks current round
  - tracks K.O.'d enemies/players/npcs
  - adds restored enemies/players/npcs back into initiative order (uses last rolled initiative)
  - tracks death saves + successes (DND)
  - tracks Effects and duration on enemies/players/npcs
  - tracks abilities, ability usage and supports sharability
  - saves creatures, effects, abilities and special events (globaly stored for reuse)

**Data Models - General Scope**
  1. Tracker
  2. Creature
  3. Effect
  4. Special Event (Die of Doom)
  5. Ability (Global)
  6. CreatureAbility (join table, makes abilities reusable, you can revoke abilities as well)
  7. AbilityUsages (tracks abilities usage per combat tracker, helps with battle history/reporting)

**Tracker Details**
  - tracks its name
  - tracks of round (counter)
  - tracks current turn (first element in array)
  - tracks initative order (array)
  - sorts initiative order by initative roll
  - adds combantants to intitative order
  - marks active turn in initative order

**Creature Details**
  - tracks its name
  - role (player, NPC, or monster)
  - initative roll
  - dead attr + methods to kill creature
  - tracks hit points, temp hit points and max hp
  - tracks death save successes and failures
  - resets death saves 
  - tracks tracker it belongs to

**Effect Details**
  - tracks name of effect
  - tracks type (buff, debuff, neutral)
  - tracks duration
  - has a description
  - tracks creature it belongs to

**Special Events Details**
- tracks name
- tracks description
- tracks frequency
- tracks tracker it belongs to

**Abilities Details**
- global abilities for a creature
- User can be managed and created outside a tracker
- User can assign/re-use them at a later point
- keeps a description of ability
- tracks usage type (unlimited, limited, cooldown, nil)
- tracks default usage limit (global)
- tracks default cool down (global)

**Creature_Abilities Details**
- it's a Join Table
- assigns an ability to a creature
- tracks usage limit (specific creature)
- tracks cool down (specific creature)
- User can add notes or additional descriptions

**Ability_Usages Details**
- tracks tracker, creature and ability it belongs to
- tracks when it was used (time stamp)
- tracks what round it was used
- tracks how long on cool down