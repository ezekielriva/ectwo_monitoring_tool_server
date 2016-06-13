require 'sinatra'
require 'sinatra/json'
require 'dotenv'
require "#{__dir__}/services/machine_stats"

Dotenv.load

set(:auth) do |*keys|
  condition do
    if !keys.include? params['key']
      redirect to('/unauthorized')
    end
  end
end


get '/' do
  json({details: 'EC2 Monitoring Tool is working perfectly',status: 200})
end

get '/cpu_usage.json', auth: ENV['AUTH_KEY'] do
  machine_stats = MachineStats.new

  json({
    cpu_usage:            machine_stats.cpu_usage,
    cpu_usage_percentage: machine_stats.cpu_usage_percentage
  })
end

get '/mem_usage.json', auth: ENV['AUTH_KEY'] do
  machine_stats = MachineStats.new

  json({
    mem_total:            machine_stats.mem_total,
    mem_active:           machine_stats.mem_active,
    mem_usage_percentage: machine_stats.mem_usage_percentage
  })
end

get '/running_process.json', auth: ENV['AUTH_KEY'] do
  machine_stats = MachineStats.new

  json({running_process: machine_stats.running_process})
end

get '/unauthorized' do
  json({name: 'Unauthorized', details: 'You\'r using an unauthorized key', status: 403})
end
