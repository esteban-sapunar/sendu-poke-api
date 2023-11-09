require 'rails_helper'

RSpec.describe "V1::PokemonsController", type: :request do
  describe "GET /index" do
    it "Should return complete pokemon list" do
      pokemon = create(:pokemon)
      get v1_pokemons_path 

      expect(response.body).to eq([pokemon].to_json)
    end
  end
  describe "GET /show" do
    it "Should return a pokemon by id" do
      pokemon = create(:pokemon)
      get v1_pokemon_path(id: pokemon.id) 

      expect(response.body).to eq(pokemon.to_json)
    end
  end
  describe "POST /create" do
    it "Should return the new pokemon" do
      pokemon = build(:pokemon)
      post v1_pokemons_path(pokemon: pokemon.attributes)
      response_data = JSON.parse(response.body)

      expect(response_data["name"]).to eq(pokemon.name)
    end
    it "Should save new pokemon in database" do
      pokemon = build(:pokemon)
      post v1_pokemons_path(pokemon: pokemon.attributes)

      expect(Pokemon.last.name).to eq(pokemon.name)
    end
  end
  describe "DELETE /destroy" do
    it "Should delete pokemon from database" do
      pokemon = create(:pokemon)
      delete v1_pokemon_path(id: pokemon.id) 

      expect(Pokemon.count).to eq(0)
    end
  end
  describe "PATCH /update" do
    it "Should update pokemon by id" do
      pokemon = create(:pokemon)
      pokemon_data = {
        id: pokemon[:id],
        pokemon:{
          name: "patch_test"
        }
      }
      patch v1_pokemon_path(pokemon_data)
      expect(Pokemon.last.name).to eq("patch_test")
    end
  end
end
