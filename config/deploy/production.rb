set :deploy_to, "/home/kembo/www/glico/production/"
set :user, "kembo"

role :app, "114.80.203.11"
role :web, "114.80.203.11"
role :db,  "114.80.203.11", :primary => true
# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  task :trust_rvmrc do
      run "rvm rvmrc trust #{latest_release}"
  end

  # RAILS_ENV=production rake assets:precompile
  task "assets", :roles => :app do
    run "cd #{current_path}; RAILS_ENV=production bundle exec rake assets:precompile"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "cp /home/kembo/www/glico/production/deploy/database.yml /home/kembo/www/glico/production/current/config/."
    run "touch #{current_path}/tmp/restart.txt"
  end
end
