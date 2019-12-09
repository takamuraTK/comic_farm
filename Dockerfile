# first stage
FROM ruby:2.5.3-alpine as builder
RUN apk --update add --virtual=buildings \
    build-base \
    curl-dev \
    mysql-dev \
    nodejs \
    libxml2-dev \
    git
RUN gem install bundler
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install -j4
RUN apk del buildings

# final stage
FROM ruby:2.5.3-alpine
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo
RUN apk --update add \
    bash \
    nodejs \
    mysql-dev \
    tzdata \
    yarn 
RUN gem install bundler
WORKDIR /tmp
COPY --from=builder /usr/local/bundle /usr/local/bundle

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME
ENV RAILS_ENV production
RUN rm -f tmp/pids/server.pid
VOLUME /app/public
VOLUME /app/tmp
EXPOSE  3000
WORKDIR /app/tmp
RUN mkdir sockets
WORKDIR $APP_HOME

CMD bundle exec puma 