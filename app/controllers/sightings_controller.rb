class SightingsController < ApplicationController
  def index
    sightings = Sighting.all
    render json: sightings
  end
  
  
  def create
    sighting = Sighting.new(sighting_params)
    if sighting.save
      render json: sighting
    else
      render json: sighting.errors.full_messages
    end
  end


  private
  def sighting_params
    params.require(:sighting).permit(:latitude,:longitude,:animal_id)
  end
end
