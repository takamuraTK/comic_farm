# first stage
FROM ruby:2.5.3-alpine as builder
RUN apk --no-cache add --virtual=buildings \
    build-base=0.5-r1 \
    curl-dev=7.64.0-r3 \
    mariadb-connector-c-dev=3.0.8-r0 \
    nodejs=10.14.2-r0 \
    libxml2-dev=2.9.9-r2
RUN gem install bundler:2.0.2
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install -j4
RUN apk del buildings

# final stage
FROM ruby:2.5.3-alpine
ENV LANG ja_JP.UTF-8
ENV TZ=Asia/Tokyo
RUN apk --no-cache add \
    bash=4.4.19-r1 \
    nodejs=10.14.2-r0 \
    mariadb-connector-c-dev=3.0.8-r0 \
    tzdata=2019c-r0 \
    yarn=1.12.3-r0
RUN gem install bundler:2.0.2
WORKDIR /tmp
COPY --from=builder /usr/local/bundle /usr/local/bundle

WORKDIR /app/tmp
RUN mkdir sockets
RUN mkdir pids

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . $APP_HOME
ENV RAILS_ENV production
RUN rm -f tmp/pids/server.pid
VOLUME /app/public
VOLUME /app/tmp
EXPOSE  3000

CMD ["bundle", "exec", "puma"]