require 'sinatra'
require 'sinatra/json'

get '/' do
  json({details: 'EC2 Monitoring Tool is working perfectly',status: 200})
end

get '/cpu_usage.json' do
  proc0 = File.readlines('/proc/stat').grep(/^cpu /).first.split(" ")
  sleep 1
  proc1 = File.readlines('/proc/stat').grep(/^cpu /).first.split(" ")

  proc0usagesum = proc0[1].to_i + proc0[2].to_i + proc0[3].to_i
  proc1usagesum = proc1[1].to_i + proc1[2].to_i + proc1[3].to_i
  procusage = proc1usagesum - proc0usagesum

  proc0total = 0
  for i in (1..4) do
    proc0total += proc0[i].to_i
  end
  proc1total = 0
  for i in (1..4) do
    proc1total += proc1[i].to_i
  end
  proctotal = (proc1total - proc0total)

  cpuusage = (procusage.to_f / proctotal.to_f).round(3)
  cpuusagepercentage = (100 * cpuusage).to_f.round(2)

  json({cpu_usage: cpuusage, cpu_usage_percentage: cpuusagepercentage})
end
