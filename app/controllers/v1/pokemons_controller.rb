class V1::PokemonsController < ApplicationController
  def index 
    @pokemons = Pokemon.all

    render json: @pokemons, status: :ok
  end

  def show 
    @pokemon = Pokemon.find(params[:id])

    render json: @pokemon, status: :ok
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    @pokemon.save
    render json: @pokemon, status: :created
  end

  def update 
    @pokemon = Pokemon.find(params[:id])
    @pokemon.update(pokemon_params)

    render json: @pokemon, status: :ok
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    name = @pokemon.name

    if @pokemon.destroy
      render json: {name: name, status: :deleted }, status: :ok
    else
      head(:unprocessable_entity)
    end
  end

  private 

  def pokemon_params 
    params.require(:pokemon).permit(:name,:order,:base_experience,:height,:weight,types:[])
  end
end
