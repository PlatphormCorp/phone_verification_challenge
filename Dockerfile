# Use ruby 2.7.1 as the base image
FROM ruby:2.7.1

# Set the working directory to /app
WORKDIR /app

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    yarn \
    sqlite3 \
    libsqlite3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the Gemfile and Gemfile.lock from the app directory
COPY Gemfile Gemfile.lock ./

# Install the bundled gems
RUN bundle install

# Copy the rest of the application code into the image
COPY . .

# Run the database migrations
RUN rails db:create db:migrate

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
