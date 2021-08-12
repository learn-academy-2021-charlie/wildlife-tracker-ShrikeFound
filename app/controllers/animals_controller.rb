class AnimalsController < ApplicationController
  def index
    animals = Animal.all
    render json: animals
  end

  def show
    animal = Animal.find(params[:id])
    render json: animal
  end


  def create
  end

  def update
    #this is for the PUT/PATCH 'animals/"id' route
    animal = Animal.find(params[:id])
    if animal.update(animal_params)
      render json: animal
    else
      render json: animal.errors.full_message
    end
  end


  def destroy
  end


  private
  def animal_params
    params.require(:animal).permit(:common_name,:latin_name,:animal_class)
  end


end
