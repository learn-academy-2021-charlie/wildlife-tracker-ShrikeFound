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
  end


  def destroy
  end


  private

end
