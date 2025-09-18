# Use official Ruby image (same base as GitHub runner for consistency)
FROM ruby:3.1

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

# Install Jekyll and plugins
RUN gem install jekyll bundler jekyll-spaceship

# Expose Jekyll’s default server port
EXPOSE 4000

# Volume mount your site source when running
VOLUME /srv/jekyll

# Default command: serve the site (hot reload for local dev)
CMD ["jekyll", "serve", "--host", "0.0.0.0", "--livereload"]
