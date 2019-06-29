FROM ruby:2.6.3-stretch

RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client sqlite --fix-missing --no-install-recommends

WORKDIR /tmp
COPY Gemfile* ./
RUN bundle install

# Copy the app's code into the container
ENV APP_HOME /fauna
COPY . $APP_HOME
WORKDIR $APP_HOME

# RUN pwd && ls -l && ls -l config
ENV CI development
RUN ./bin/setup

EXPOSE 3000

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
