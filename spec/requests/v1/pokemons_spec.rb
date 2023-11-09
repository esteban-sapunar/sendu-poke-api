require 'swagger_helper'

RSpec.describe 'V1::PokemonsController', type: :request do
  path '/v1/pokemons' do
    get('List pokemons') do
      let!(:pokemon) { create(:pokemon) }
      tags 'Pokemons'
      description 'Lists all pokemons in the database'
      produces 'application/json'

      response(200, 'successful') do
        examples
        schema type: :array, items: {'$ref' => '#/components/schemas/pokemon'}

        run_test! do
          # Index
          # Should return complete pokemon list
          expect(response.body).to eq([pokemon].to_json)
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end
    end

    post('Create pokemon') do
      let(:pokemon) { build(:pokemon) }
      tags 'Pokemons'
      description 'Creates a new pokemon in the database'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :pokemon, in: :body, schema: {'$ref' => '#/components/schemas/pokemon_data'}
      
      response(201, 'successful') do
        examples
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          order: { type: :integer },
          base_experience: { type: :integer },
          height: { type: :integer },
          weight: { type: :integer },
          types: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string }
        }

        run_test! do
          # Create
          # Should return the new pokemon
          expect(Pokemon.last.name).to eq(pokemon.name)
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end
    end
  end

  path '/v1/pokemons/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'
    get('Show pokemon') do
      let!(:pokemon) { create(:pokemon) }
      let(:id) { pokemon.id }
      tags 'Pokemons'
      description 'Shows a pokemon from the database by id'
      produces 'application/json'

      response(200, 'successful') do
        examples
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          order: { type: :integer },
          base_experience: { type: :integer },
          height: { type: :integer },
          weight: { type: :integer },
          types: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string }
        }

        run_test! do
          # Show
          # Should return a pokemon by id         
          expect(response.body).to eq(pokemon.to_json)          
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end
    end

    patch('Update pokemon') do
      let(:new_pokemon) { create(:pokemon) }
      let(:id) { new_pokemon.id }
      let(:pokemon) do
        {
          pokemon: {
            name: 'patch_test'
          }
        }
      end
      tags 'Pokemons'
      description 'Updates a pokemon from the database by id'
      consumes 'application/json'
      parameter name: :pokemon, in: :body, schema: {'$ref' => '#/components/schemas/pokemon_data'}
      response(200, 'successful') do
        examples
        schema type: :object, properties: {
          id: { type: :integer },
          name: { type: :string },
          order: { type: :integer },
          base_experience: { type: :integer },
          height: { type: :integer },
          weight: { type: :integer },
          types: { type: :string },
          created_at: { type: :string },
          updated_at: { type: :string }
        }

        run_test! do
          # Update
          # Should update pokemon by id          
          expect(Pokemon.last.name).to eq("patch_test")          
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end
    end

    delete('Delete pokemon') do
      let!(:pokemon) { create(:pokemon) }
      let(:id) { pokemon.id }
      tags 'Pokemons'
      description 'Deletes a pokemon from the database by id'
      response(200, 'successful') do
        run_test! do
          #Destroy
          #Should delete pokemon from database
          expect(Pokemon.count).to eq(0)
        end
      end
    end
  end
end
