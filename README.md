# Setting up a fresh local Rails app

Source: https://nicolasiensen.github.io/2022-02-01-creating-a-new-rails-application-with-docker/

- Copy `docker-compose.yml` and `Dockerfile-dev` to new app directory
- Run `docker compose run --service-ports app bash`
- Once inside, run `gem install rails`
- Then `rails new . --name=<APPLICATION-NAME> --api --skip-test`
- Run `rails s -b 0.0.0.0` and ensure that `localhost:3000` is accessible via browser
- Uncomment commented out sections of `docker-compose.yml` and `Dockerfile-dev`
- Run `docker compose build`, then `docker compose up -d`, and ensure that `localhost:3000` is accessible via browser
