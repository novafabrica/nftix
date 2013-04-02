set :branch, "master"
set :deploy_to, "/var/www/nftix_production"
set :user, "deploy"
set :port, 21500
set :rails_env, 'production'

role :app, "66.175.209.241"
role :web, "66.175.209.241"
role :db,  "66.175.209.241", :primary => true


# This should be run as the last task
after "delayed_job:restart", "application:ping"

namespace :application do

  desc 'Start up app'
  task :ping, :role => :web do
    run "curl 66.175.209.241 -u client:creative#bug >/dev/null 2>&1"
  end

end
