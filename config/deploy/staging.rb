set :deploy_to, "/home/app_user/www/glico/staging/"
set :user, "app_user"

role :app, "114.80.203.77"
role :web, "114.80.203.77"
role :db,  "114.80.203.77", :primary => true

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
    run "cp /home/app_user/www/glico/staging/deploy/database.yml /home/app_user/www/glico/staging/current/config/."
    run "touch #{current_path}/tmp/restart.txt"
  end
end
