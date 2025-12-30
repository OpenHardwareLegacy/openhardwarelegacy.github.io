# Use official Ruby image (same base as GitHub runner for consistency)
FROM docker.io/library/ruby:3.1

# Install dependencies for Jekyll (Node.js, npm, build tools, etc.)
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      nodejs \
      npm \
      git \
      && rm -rf /var/lib/apt/lists/*

# Set work directory inside the container
WORKDIR /srv/jekyll

# Copy Gemfile and Gemfile.lock first (for better caching)
COPY Gemfile Gemfile.lock* ./

# Install Ruby gems via Bundler
RUN bundle install

# Expose Jekyll’s default server port
EXPOSE 4000

# Volume mount your site source when

