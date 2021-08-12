require 'rails_helper'

RSpec.describe Sighting, type: :model do
  it 'is valid with valid attributes' do 
    test_animal = Animal.create({
      common_name: "Banana Slug",
      latin_name: "Ariolimax californicus",
      animal_class: "gastropod"
    })
    test_sighting = test_animal.sightings.create(date: Date.today,latitude: 0, longitude: 0) 
    expect(test_sighting).to be_valid
  end
end
