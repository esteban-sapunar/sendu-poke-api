# Sendu Poke Api

## Description ##
  Sendu Poke API is a CRUD API that allows you to populate your database with data from the [PokeAPI](https://pokeapi.co/) and perform basic CRUD operations on Pokemon entities.

* Ruby version: 3.1.2
* Rails version: 7.1.1
## Getting Started ##
  1. Clone this repository to your local machine.
  2. Install Dependencies and Setup Database: Run the following commands to install Ruby gems, create the database, run migrations, and populate the database with Pokemon data from the PokeAPI:

  ```ruby
      bundle install
      rake deployment:setup
  ```
  3. Start the Server: Start the Rails server by running:
  ```ruby
      rails server
  ```
  4. Running Tests: To run the test suite, use the following command:
  ```ruby
      rails spec
  ```
  5. Api documentation available in local server when the project is running. [http://localhost:3000/api-docs/](http://localhost:3000/api-docs/index.html)

## API Endpoints ##

The API provides the following basic CRUD endpoints for managing Pokemon entities:

- `GET /pokemons`: Retrieve a list of all Pokemon.
- `GET /pokemons/:id`: Retrieve a specific Pokemon by its ID.
- `POST /pokemons`: Create a new Pokemon.
- `PUT /pokemons/:id`: Update an existing Pokemon by ID.
- `DELETE /pokemons/:id`: Delete a Pokemon by ID.

Ensure you have a valid API client (e.g., Postman or cURL) to interact with these endpoints.
