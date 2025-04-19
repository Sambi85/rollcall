class Effect < ApplicationRecord
  belongs_to :creature

  validates :name, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def expired?
    duration.present? && duration <= 0
  end
end
