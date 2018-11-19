use Mix.Config

config :foo, FooWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn

config :foo, Foo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "foo_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
