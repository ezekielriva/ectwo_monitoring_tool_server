require './app'

set :env,  :production

run Sinatra::Application
