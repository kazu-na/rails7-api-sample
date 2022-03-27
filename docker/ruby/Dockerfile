FROM ruby:3.1.1

RUN apt-get update -qq && apt-get -y install \
    build-essential \
    libpq-dev

WORKDIR /movie_app
COPY movie_app/Gemfile movie_app/Gemfile.lock /movie_app/

RUN gem install bundler && bundle install
COPY ./movie_app /movie_app

CMD ["rails", "s", "-p", "80", "-b", "0.0.0.0"]