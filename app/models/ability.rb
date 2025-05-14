class Ability < ApplicationRecord
  has_many :creature_abilities, dependent: :destroy
  has_many :creatures, through: :creature_abilities
  has_many :ability_usages, dependent: :destroy


  USAGE_TYPES = %w[unlimited limited cooldown]

  validates :name, presence: true, uniqueness: true
  validates :usage_type, inclusion: { in: USAGE_TYPES }
  validates :default_usage_limit, numericality: { greater_than_or_equal_to: 0 }
  validates :default_cooldown, numericality: { greater_than_or_equal_to: 0 }
end
