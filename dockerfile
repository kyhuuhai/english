# Use the official Ruby image as the base image
FROM ruby:3.2.2

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    nodejs

# Copy the Gemfile and Gemfile.lock into the image and install gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copy the rest of the application code into the image
COPY . .

# Set environment variables
ENV RAILS_ENV development

# Precompile assets
RUN bundle exec rake assets:precompile

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
