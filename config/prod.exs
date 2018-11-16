use Mix.Config

config :foo, FooWeb.Endpoint,
  http: [port: {:system, :integer, "FOO_HTTP_PORT"}],
  # This is critical for ensuring web-sockets properly authorize.
  url: [host: "localhost", port: {:system, :integer, "FOO_HTTP_PORT"}],
  # http: [port: {:system, "PORT"}],
  # url: [host: "localhost", port: {:system, "PORT"}], # This is critical for ensuring web-sockets properly authorize.
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  root: ".",
  version: Application.spec(:phoenix_distillery, :vsn)

# Do not print debug messages in production
config :logger, level: :info

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :foo, FooWeb.Endpoint, secret_key_base: "LkuWAYWheEUv2SADqEEzUTW38N8ZexN/2iOKy7y9slvK3Cghnc8viSAYQtD69lya"

# Configure your database
config :foo, Foo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: {:system, :string, "FOO_POSTGRES_USER"},
  password: {:system, :string, "FOO_POSTGRES_PASSWORD"},
  database: {:system, :string, "FOO_POSTGRES_DATABASE"},
  pool_size: 15
