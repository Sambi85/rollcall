class SpecialEvent < ApplicationRecord
  belongs_to :tracker, optional: true

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :frequency, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
