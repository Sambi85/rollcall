# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_12_125954) do
  create_table "abilities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "usage_type"
    t.integer "default_usage_limit", default: 0
    t.integer "default_cooldown", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ability_usages", force: :cascade do |t|
    t.integer "tracker_id", null: false
    t.integer "creature_id", null: false
    t.integer "ability_id", null: false
    t.datetime "used_at"
    t.integer "round_used", default: 0
    t.integer "cooldown_remaining", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_ability_usages_on_ability_id"
    t.index ["creature_id"], name: "index_ability_usages_on_creature_id"
    t.index ["tracker_id"], name: "index_ability_usages_on_tracker_id"
  end

  create_table "creature_abilities", force: :cascade do |t|
    t.integer "creature_id", null: false
    t.integer "ability_id", null: false
    t.integer "usage_limit", default: 0
    t.integer "cooldown_rounds", default: 0
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ability_id"], name: "index_creature_abilities_on_ability_id"
    t.index ["creature_id"], name: "index_creature_abilities_on_creature_id"
  end

  create_table "creatures", force: :cascade do |t|
    t.string "name"
    t.string "role"
    t.integer "initiative"
    t.boolean "dead"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tracker_id"
    t.integer "current_hp", default: 0, null: false
    t.integer "max_hp", default: 0, null: false
    t.integer "temp_hp", default: 0, null: false
    t.integer "death_saves_successes", default: 0, null: false
    t.integer "death_saves_failures", default: 0, null: false
    t.index ["tracker_id"], name: "index_creatures_on_tracker_id"
  end

  create_table "effects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "duration"
    t.string "status_type"
    t.integer "creature_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creature_id"], name: "index_effects_on_creature_id"
  end

  create_table "special_events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "frequency"
    t.integer "tracker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tracker_id"], name: "index_special_events_on_tracker_id"
  end

  create_table "trackers", force: :cascade do |t|
    t.integer "round"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "turn_order", default: "--- []"
    t.string "name"
  end

  add_foreign_key "ability_usages", "abilities"
  add_foreign_key "ability_usages", "creatures"
  add_foreign_key "ability_usages", "trackers"
  add_foreign_key "creature_abilities", "abilities"
  add_foreign_key "creature_abilities", "creatures"
  add_foreign_key "creatures", "trackers"
  add_foreign_key "effects", "creatures"
  add_foreign_key "special_events", "trackers"
end
