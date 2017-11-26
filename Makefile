test:
	docker-compose run --rm app bundle exec rspec 

bundle:
	docker-compose run --rm app bundle install

build:
	docker-compose build

run:
	docker-compose up

start:
	docker-compose start

stop:
	docker-compose stop

migrate:
	docker-compose run --rm app bundle exec rake db:migrate

pronto:
	docker-compose run --rm app bundle exec pronto run
