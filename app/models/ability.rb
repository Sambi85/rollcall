class Ability < ApplicationRecord
  has_many :creature_abilities, dependent: :destroy
  has_many :creatures, through: :creature_abilities

  has_many :ability_usages, dependent: :destroy

  validates :name, presence: true
  validates :usage_type, inclusion: { in: %w[unlimited limited cooldown] }, allow_nil: true
end
