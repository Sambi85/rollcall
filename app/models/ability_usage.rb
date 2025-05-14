class AbilityUsage < ApplicationRecord
  belongs_to :tracker
  belongs_to :creature
  belongs_to :ability
end
