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
    animal = Animal.new(animal_params)
    if animal.save 
      render json: animal 
    else
      render animal.errors.full_messages
    end
  end

  def update
    #this is for the PUT/PATCH '/animals/"id' route
    animal = Animal.find(params[:id])
    if animal.update(animal_params)
      render json: animal
    else
      render json: animal.errors.full_messages
    end
  end


  def destroy
    #this is for the DELETE '/animals/:id' route
    animal = Animal.find(params[:id])
    animal.destroy
    #return nothing
    head :no_content
  end


  private
  def animal_params
    params.require(:animal).permit(:common_name,:latin_name,:animal_class)
  end


end
