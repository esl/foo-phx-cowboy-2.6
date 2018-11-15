use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :foo, FooWeb.Endpoint,
  http: [port: 6662],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :foo, Foo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "foo_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
