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

  it "is invalid if missing lat,long, or date" do
    
    test_animal = Animal.create({
      common_name: "Banana Slug",
      latin_name: "Ariolimax californicus",
      animal_class: "gastropod"
    })

    test_sighting_without_date = test_animal.sightings.create({
      latitude: 0, 
      longitude: 0
    }) 

    test_sighting_without_lat = test_animal.sightings.create({
      date: Date.today,
      longitude: 0
    }) 

    test_sighting_without_long = test_animal.sightings.create({
      date: Date.today,
      latitude: 0
    }) 

    expect(test_sighting_without_date.errors[:date]).to_not be_empty
    expect(test_sighting_without_lat.errors[:latitude]).to_not be_empty
    expect(test_sighting_without_long.errors[:longitude]).to_not be_empty

  end


end
