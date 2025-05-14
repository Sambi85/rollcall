class CreatureAbility < ApplicationRecord
  belongs_to :creature
  belongs_to :ability

  validates :creature_id, uniqueness: { scope: :ability_id, message: "already has this ability assigned" }
  validates :usage_limit, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :cooldown_rounds, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validate :respect_global_usage_type

  private

  def respect_global_usage_type
    case ability&.usage_type
    when "limited"
      errors.add(:usage_limit, "must be set for limited-use abilities") if usage_limit.nil?
    when "cooldown"
      errors.add(:cooldown_rounds, "must be set for cooldown abilities") if cooldown_rounds.nil?
    end
  end
end
