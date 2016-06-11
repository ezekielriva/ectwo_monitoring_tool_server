lock '3.5.0'

set :application, 'ectwo_monitoring_tool_server'
set :repo_url, 'git@github.com:ezekielriva/ectwo_monitoring_tool_server.git'

set :deploy_to, '/var/www/ectwo_monitoring_tool_server'

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
