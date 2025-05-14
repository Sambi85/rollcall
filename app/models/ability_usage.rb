class AbilityUsage < ApplicationRecord
  belongs_to :tracker
  belongs_to :creature
  belongs_to :ability

  validates :tracker_id, :creature_id, :ability_id, presence: true
  validates :round_used, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooldown_remaining, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :creature_has_ability

  private

  def creature_has_ability
    unless creature.abilities.include?(ability)
      errors.add(:ability, "is not assigned to this creature")
    end
  end
end
