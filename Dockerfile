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
    apt-get install --no-install-recommends -y build-essential libpq-dev git libvips pkg-config postgresql-client

# Install application gems
COPY Gemfile Gemfile.lock bundler.sh ./

RUN bash ./bundler.sh
RUN rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

RUN for file in config/*.yml.example; do mv "$file" "${file%%.example}"; done

# Final stage for app image
FROM base

# Install packages needed for deployment and PostgreSQL
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl postgresql-contrib libvips && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000

# Sidekiq port
EXPOSE 7433

CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
