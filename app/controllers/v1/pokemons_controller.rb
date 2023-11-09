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

    if @pokemon.save
      render json: @pokemon, status: :created
    else
      head(:unprocessable_entity)
    end
  end

  def update 
    @pokemon = Pokemon.find(params[:id])
    
    if @pokemon.update(pokemon_params)
      render json: @pokemon, status: :ok
    else
      head(:unprocessable_entity)
    end
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
