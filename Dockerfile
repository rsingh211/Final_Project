# Dockerfile
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs sqlite3

# Set working directory
WORKDIR /app

# Preinstall bundler
RUN gem install bundler

# Add Gemfile first and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Add the app code
COPY . .

# Clear old server pid if any
RUN rm -f tmp/pids/server.pid

# Precompile assets and setup db (optional)
RUN bundle exec rake db:setup

# Expose the port and run the server
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
