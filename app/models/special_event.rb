class SpecialEvent < ApplicationRecord
  belongs_to :tracker, optional: true

  validates :name, presence: true
  validates :description, presence: true
  validates :frequency, presence: true
end
