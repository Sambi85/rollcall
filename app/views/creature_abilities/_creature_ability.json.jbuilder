json.extract! creature_ability, :id, :creature_id, :ability_id, :usage_limit, :cooldown_rounds, :notes, :created_at, :updated_at
json.url creature_ability_url(creature_ability, format: :json)
