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

**Todo**
  - Status, Concentration and Conditions (CRUD)
  - HP tracking (CRU)
  - Die of Doom tracker
  - Make MVC backend w/ API
  - Make CSV Import for easy combat setup
  - Make CSV Log Export for useful post combat data
  - Make readme for CSV Import/Export