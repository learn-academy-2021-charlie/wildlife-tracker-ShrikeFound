class CreateAnimals < ActiveRecord::Migration[6.1]
  def change
    create_table :animals do |t|
      t.string :common_name
      t.string :latin_name
      t.string :animal_class

      t.timestamps
    end
  end
end
