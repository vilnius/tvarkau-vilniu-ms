# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, 'tvarkauvilniums'
# set :repo_url, 'git@github.com:vilnius/tvarkau-vilniu-ms.git'
set :repo_url, 'git@github.com:laurynas/tvarkau-vilniu-ms.git'
set :branch, 'feature/docker_deploy' # default is master
set :deploy_to, "/home/tvrkvlnapp/apps/#{fetch(:application)}-#{fetch(:stage)}"

set :docker_image, "vilnius/#{fetch(:application)}:#{fetch(:stage)}"
set :docker_compose_file, "docker-compose.#{fetch(:stage)}.yml"
set :docker_stack, "#{fetch(:application)}-#{fetch(:stage)}"

# make alias 'tvarkauvilniu' to the real server in ~/.ssh/config
server 'tvarkauvilniu', roles: %w{app db web}

namespace :docker do
  task :update do
    on roles(:app) do
      within release_path do
        execute :docker, :image, :build, '.', "-t #{fetch(:docker_image)}"
        execute :docker, :stack, :deploy, "--compose-file #{fetch(:docker_compose_file)}", '--resolve-image never', fetch(:docker_stack)
        execute :docker, :service, :update, "#{fetch(:docker_stack)}_app", '--force --update-parallelism 1 --detach=false'
        execute :docker, :container, :prune, '-f'
        execute :docker, :image, :prune, '-f'
      end
    end
  end
end

after 'deploy:published', 'docker:update'
