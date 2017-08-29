require('sinatra')
require('sinatra/contrib/all')
require("sinatra/reloader") if development?
require('pry-byebug')
require("pry")
require_relative("../models/owner.rb")
require_relative("../models/pet.rb")
require_relative("../models/sql_runner.rb")


######## show all owners
get '/owners' do
  @owners = Owner.all
  erb(:"owners/index")
end

######## new owner form
get '/owners/new' do
  erb(:"owners/new")
end

#### add new owner to database
post "/owners" do
  @owner = Owner.new(params)
  @owner.save
  redirect to "/owners"
end

##### view individual owner
get "/owners/:id" do
  @owner = Owner.find(params[:id])
  @pets = @owner.pets
  erb(:"owners/show")
end

##### delete owner
post '/owners/:id/delete' do
  @owner = Owner.find(params[:id])
  @owner.delete
  redirect to '/owners'
end

##### give update owner form
post '/owners/:id/edit' do
  @owner = Owner.find(params[:id])
  erb(:"owners/update")
end

#### submit update owner form details
post '/owners/:id' do
  @owner = Owner.new(params)
  @owner.update
  redirect to "/owners/#{@owner.id}"
end
