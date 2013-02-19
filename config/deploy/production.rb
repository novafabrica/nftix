set :branch, "production"
set :deploy_to, "/var/www/creativebug_production"
set :user, "deploy"
set :port, 21500
set :rails_env, 'production'

role :app, "173.255.243.210"
role :web, "173.255.243.210"
role :db,  "173.255.243.210", :primary => true


# This should be run as the last task
after "delayed_job:restart", "application:ping"

namespace :application do

  desc 'Start up app'
  task :ping, :role => :web do
    run "curl 173.255.243.210 -u client:creative#bug >/dev/null 2>&1"
  end

end

namespace :solr do

  desc 'Upload config files'
  task :upload_config do
    upload("lib/schema.xml", "/home/deploy/solr/schema.xml")
  end

end