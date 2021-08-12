class Animal < ApplicationRecord
  has_many :sightings

  #validate using custom method
  validate :common_name_cannot_match_latin_name

  validates :common_name, presence: true
  validates :latin_name, presence: true





  #custom method to check if names match
  def common_name_cannot_match_latin_name 
    if common_name == latin_name
      errors.add(:latin_name, "latin name and common name cannot be the same.")
    end
  end
end
