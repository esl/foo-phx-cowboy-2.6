FROM bitwalker/alpine-elixir:1.7.4 as builder

COPY . .

RUN apk update && apk add make && rm -rf /var/cache/apk/*

RUN make prod_build_release && tar zcvpf /opt/app/foo.tar.gz /opt/app/_build/prod/rel/foo

FROM bitwalker/alpine-elixir:1.7.4 

COPY --from=builder /opt/app/foo.tar.gz /tmp/foo.tar.gz

RUN tar zxvfp /tmp/foo.tar.gz -C /tmp && cp -pr /tmp/opt/app/_build/prod/rel/foo /opt/app/ && rm -rf /opt/app/.hex && rm -rf /opt/app/.mix

ENTRYPOINT ["/opt/app/foo/bin/foo"]

CMD ["help"]
