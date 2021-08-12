class AddDateToSightings < ActiveRecord::Migration[6.1]
  def change
    add_column :sightings, :date, :datetime
  end
end
