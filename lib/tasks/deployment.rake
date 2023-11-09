namespace :deployment do
  desc "App fast deployment"
  task setup: :environment do
    puts "Starting ..."
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['pokemon_data:load'].invoke
    puts "..."
    puts "Ready to launch, use 'rails server' to run the application"
  end
end