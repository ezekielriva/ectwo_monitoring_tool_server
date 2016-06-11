require 'dotenv'
Dotenv.load

server ENV['AWS_SERVER'], user: ENV['AWS_USER'], roles: %w{web app}
