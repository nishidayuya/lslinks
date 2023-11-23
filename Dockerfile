FROM ruby:3.2-alpine AS build

WORKDIR /opt/app
COPY . .
RUN set -eux && \
    apk add --no-cache build-base git libxml2-dev && \
    bundle install && \
    bundle exec rake build && \
    git rev-parse HEAD > pkg/COMMIT-ID

FROM ruby:3.2-alpine
RUN set -eux && \
    apk add --no-cache libxml2
COPY --from=build /opt/app/pkg/* /usr/src/
RUN set -eux && \
    apk add --no-cache --virtual build-dependencies build-base libxml2-dev && \
    gem install /usr/src/*.gem && \
    apk del --no-cache build-dependencies

ENTRYPOINT ["lslinks"]
