class Animal < ApplicationRecord
  has_many :sightings

  validates :common_name, presence: true
  validates :latin_name, presence: true
end
