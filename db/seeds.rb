# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Animal.destroy_all

animals = [
  {
    common_name: "Arctic Fox",
    latin_name: "Alopex Vulpini",
    animal_class: "mammal"
  },
  {
    common_name: "Ladybird Beetle",
    latin_name: "Coccinella magnifica",
    animal_class: "insect"
  },
  {
    common_name: "Banana Slug",
    latin_name: "Ariolimax californicus",
    animal_class: "gastropod"
  },



]

animals.each do |animal|
  Animal.create animal
end