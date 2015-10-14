# config valid only for current version of Capistrano
lock '3.4.0'

set :application, "GMP"
# Bundler to handle gems and package everything locally with the app.
# The --binstubs flag means any gem executables will be added to <app>/bin.
set :bundle_flags, " --binstubs --quiet"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
set :scm, :hg
set :repo_url, 'https://quicksilver/hg/rcc/claims_policy_query_tool/'

set :use_sudo, false

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# The .profile PATH settings we added earlier won't get run by Capistrano, add the rbenv paths to deploy.rb
set :default_environment, {'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"}

# Default value for keep_releases is 5
set :keep_releases, 1

namespace :deploy do
  task :restart do
    # nginx is configured to bring up rails application under /var/www/rails_app/depauto/current/public
    run "sudo /etc/init.d/nginx restart"
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :app do
  task :precompile do
    run "cd #{deploy_to}/current; bundle exec rake assets:precompile"
  end
end

namespace :db do
  task :restore do
    if file_exists?("#{previous_release}/db/#{rails_env}.sqlite3")
      run "cp #{previous_release}/db/#{rails_env}.sqlite3 #{deploy_to}/current/db/#{rails_env}.sqlite3"
      run "cd #{deploy_to}/current; bundle exec rake RAILS_ENV=#{rails_env} db:migrate"
    else
      puts " ********************************************************************** "
      puts " No previous deployment. Setting up database with defaults "
      puts " ********************************************************************** "
      run "cd #{deploy_to}/current; bundle exec rake RAILS_ENV=#{rails_env} db:drop; bundle exec rake RAILS_ENV=#{rails_env} db:create; bundle exec rake RAILS_ENV=#{rails_env} db:migrate; bundle exec rake RAILS_ENV=#{rails_env} db:seed"
    end
  end
end
