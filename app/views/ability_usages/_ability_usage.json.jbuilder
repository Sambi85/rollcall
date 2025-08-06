json.extract! ability_usage, :id, :tracker_id, :creature_id, :ability_id, :used_at, :round_used, :cooldown_remaining, :created_at, :updated_at
json.url ability_usage_url(ability_usage, format: :json)
