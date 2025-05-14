class CreatureAbility < ApplicationRecord
  belongs_to :creature
  belongs_to :ability
end
