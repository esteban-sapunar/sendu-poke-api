require 'net/http'
module PokemonDataHelper
  def self.add_pokemon_data(url,name)
    uri = URI(url)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
      request = Net::HTTP::Get.new uri
      response = http.request request
      data = JSON.parse(response.body)
      types = data["types"].map{ |type| type["type"]["name"] }
      types_string = types.join(",")
      new_pokemon = Pokemon.new( name: name,
        order: data["order"],
        base_experience: data["base_experience"],
        height: data["height"],
        weight: data["weight"],
        types: types_string )
      new_pokemon.save
    end
  end
end
