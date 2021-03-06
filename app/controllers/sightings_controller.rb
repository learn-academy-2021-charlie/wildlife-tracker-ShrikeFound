class SightingsController < ApplicationController
  #so that I can see all the created sightings
  def index
    start_date = params[:start_date].to_date || Date.today.at_beginning_of_month
    end_date   = params[:end_date].to_date ||  Date.today.at_beginning_of_month.next_month
    
    sightings = Sighting.where(date: start_date..end_date)
    render json: sightings
  end
  
  ##index method from example:
  # def index
  #   sightings = Sighting.where(date: params[:start_date]..params[:end_date])
  #   render json: sightings
  # end

  def show
    sighting = Sighting.find(params[:id])
    render json: sighting
  end
  #I feel like there's a better way to do this but I'll need to look a bit more.
  def create
    sighting = Sighting.new(sighting_params)
    if sighting.save
      render json: sighting
    else
      render json: sighting.errors.full_messages
    end
  end

  def update 
    sighting = Sighting.find(params[:id])
    if sighting.update(sighting_params)
      render json: sighting 
    else
      render json: sighting.errors.full_messages
    end
  end

  def destroy
    sighting = Sighting.find(params[:id])
    sighting.destroy
    head :no_content
  end



  private
  def sighting_params
    params.require(:sighting).permit(:date,:latitude,:longitude,:animal_id)
  end
end
