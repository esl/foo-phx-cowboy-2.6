FROM bitwalker/alpine-elixir:1.7.4 as builder

ARG tag="latest"

ENV TAG=${tag}

RUN apk update && apk add make && rm -rf /var/cache/apk/*

COPY . .

RUN MIX_ENV=prod mix deps.get --only prod && MIX_ENV=prod mix do compile, phx.digest, release

FROM bitwalker/alpine-elixir:1.7.4 

ARG tag="latest"

ENV TAG=${tag}

RUN apk update && apk add make && rm -rf /var/cache/apk/*

COPY --from=builder \
    /opt/app/_build/prod/rel/foo/releases/*/foo.tar.gz \
    /opt/app/

WORKDIR /opt/app

RUN tar zxvfp ./foo.tar.gz && \
    rm -rf ./foo.tar.gz && \
    rm -rf ./.hex && \
    rm -rf ./.mix 

LABEL TAG="${TAG}" maintainer="binarytemple"

ENTRYPOINT ["/opt/app/bin/foo"]

CMD ["help"]
