# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.2
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set production environment
ARG RAILS_ENV
ENV RAILS_ENV=${RAILS_ENV:-development} \
    BUNDLE_PATH="/usr/local/bundle"

# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems and PostgreSQL client
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev git libvips pkg-config

# Install application gems
COPY Gemfile Gemfile.lock bundler.sh ./

# Install PG Gem with libpq-dev
RUN gem install bundler -v 2.5.6
RUN gem install pg  --   --with-pg-lib=/usr/lib 

RUN bash ./bundler.sh

# Copy application code
COPY . .

RUN for file in config/*.yml.example; do mv "$file" "${file%%.example}"; done

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000

# Sidekiq port
EXPOSE 7433

CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
