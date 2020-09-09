FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /gcp_rails_test
WORKDIR /gcp_rails_test
COPY Gemfile /gcp_rails_test/Gemfile
COPY Gemfile.lock /gcp_rails_test/Gemfile.lock
RUN bundle install
COPY . /gcp_rails_test

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]