require 'rails_helper'

RSpec.describe Animal, type: :model do
  
  it 'is valid with valid attributes' do
  test_animal = Animal.create({
      common_name: "Banana Slug",
      latin_name: "Ariolimax californicus",
      animal_class: "gastropod"
  })
    expect(test_animal).to be_valid
  end

  it 'is invalid without a common name' do
    test_animal = Animal.create({
      latin_name: "Ariolimax californicus",
      animal_class: "gastropod"
    })

    expect(test_animal.errors[:common_name]).to_not be_empty

  end


  it 'is invalid without a latin name' do
    test_animal = Animal.create({
      common_name: "Banana Slug",
      animal_class: "gastropod"
    })

    expect(test_animal.errors[:latin_name]).to_not be_empty

  end


  # it 'is invalid without a latin name' do
  #   test_animal = Animal.create({
  #     common_name: "Banana Slug",
  #     animal_class: "gastropod"
  #   })

  #   expect(test_animal.errors[:latin_name]).to_not be_empty

  # end




end
