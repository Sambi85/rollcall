class Creature < ApplicationRecord
  belongs_to :tracker, optional: true

  enum role: { player: 'player', npc: 'npc', monster: 'monster' }

  def kill
    update(dead: true)
  end
end
