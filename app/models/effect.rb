class Effect < ApplicationRecord
  belongs_to :creature, optional: true

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }, allow_nil: true
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :status_type, inclusion: { in: %w[buff debuff neutral] }

  def expired?
    duration.present? && duration <= 0
  end
end
