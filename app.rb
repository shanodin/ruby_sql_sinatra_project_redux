require( 'sinatra' )
require( 'sinatra/contrib/all' )
require("sinatra/reloader") if development?
require('pry-byebug')
require("pry")
require_relative("./controllers/owner_controller.rb")
 require_relative("./controllers/pet_controller.rb")

get '/' do
  erb( :index )
end
