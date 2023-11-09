require 'net/http'
require 'tasks_helpers/pokemon_data_helper'

namespace :pokemon_data do
  desc "Pokemon data bulk load"
  task load: :environment do
    puts "Starting Loading..."
    Pokemon.delete_all
    uri = URI('https://pokeapi.co/api/v2/pokemon?limit=-1')

    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request
      data = JSON.parse(response.body)
      list = data["results"]
      puts "#{data["count"]} pokemons to load."
      list.each_with_index do |pokemon,index|
        printf("\rLoading #{index+1} of #{data["count"]}.")
        PokemonDataHelper.add_pokemon_data(pokemon["url"],pokemon["name"])
      end
      printf("\rLoaded #{data["count"]}. pokemons")
    end
  end
end
