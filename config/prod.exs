use Mix.Config

config :foo, FooWeb.Endpoint,
  http: [port: {:system, :integer, "FOO_HTTP_PORT"}],
  url: [host: "localhost", port: {:system, :integer, "FOO_HTTP_PORT"}],
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: ".",
  version: Application.spec(:phoenix_distillery, :vsn)

config :logger, level: :info

config :foo, FooWeb.Endpoint, secret_key_base: "LkuWAYWheEUv2SADqEEzUTW38N8ZexN/2iOKy7y9slvK3Cghnc8viSAYQtD69lya"

config :foo, Foo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: {:system, :string, "FOO_POSTGRES_USER"},
  password: {:system, :string, "FOO_POSTGRES_PASSWORD"},
  database: {:system, :string, "FOO_POSTGRES_DATABASE"},
  pool_size: 15
