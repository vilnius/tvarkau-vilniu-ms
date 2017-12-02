# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, 'tvarkau-vilniu-ms'
# set :repo_url, 'git@github.com:vilnius/tvarkau-vilniu-ms.git'
set :repo_url, 'git@github.com:laurynas/tvarkau-vilniu-ms.git'
set :branch, 'feature/docker_deploy' # default is master
set :deploy_to, "/home/tvrkvlnapp/apps/#{fetch(:application)}-#{fetch(:stage)}"

set :docker_image, "vilnius/tvarkauvilniums:#{fetch(:stage)}"
set :docker_project, 'tvarkauvilniums'
set :docker_compose_file, 'docker-compose.production.yml'

server '10.13.3.82', user: 'tvrkvlnapp', roles: %w{app db web}

namespace :docker do
  task :update do
    on roles(:app) do
      within release_path do
        execute :docker, :image, :build, '.', "-t #{fetch(:docker_image)}"
        # execute 'docker-compose', "-p #{fetch(:docker_project)}", "-f #{fetch(:docker_compose_file)}", 'push'
        execute :docker, :stack, :deploy, "--compose-file #{fetch(:docker_compose_file)}", "#{fetch(:docker_project)}-#{fetch(:stage)}"
      end
    end
  end
end

after 'deploy:published', 'docker:update'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
