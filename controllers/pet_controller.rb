require('sinatra')
require('sinatra/contrib/all')
require("sinatra/reloader") if development?
require('pry-byebug')
require("pry")
require_relative("../models/owner.rb")
require_relative("../models/pet.rb")
require_relative("../models/sql_runner.rb")


######## show all pets
get '/pets' do
  @pets = Pet.all
  erb(:"pets/index")
end

##### ready for Adoption
get '/pets/adoptable' do
  @pets = Pet.adoptable()
  erb(:"pets/adoptable")
end

###### new pet form
get '/pets/new' do
  erb(:"pets/new")
end

##### add new pet to database
post "/pets" do
  @pet = Pet.new(params)
  @pet.save
  redirect to "/pets"
end

###### view individual pet
get "/pets/:id" do
  @pet = Pet.find(params[:id])
  owner_id = @pet.owner_id
  puts "ONWER ID #{owner_id}"
  if owner_id
    @owner = Owner.find(owner_id)
  else
    @owner = false
  end
  erb(:"pets/show")
end

##### delete pet
get '/pets/:id/delete' do
  @pet = Pet.find(params[:id])
  @pet.delete
  redirect to '/pets'
end

#### give update pet form
get '/pets/:id/edit' do
  @pet = Pet.find(params[:id])
  @owners = Owner.all

  erb(:"pets/update")
end

#### submit pet update form
post '/pets/:id' do
  @pet = Pet.new(params)
  @pet.update
  redirect to "/pets/#{@pet.id}"
end
