use Mix.Config

config :foo,
  ecto_repos: [Foo.Repo]

config :foo, FooWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "H0A1suhHiotDGCYOTkJqHODiUxRvTnm/7+4jOKy1GTg3uq5VZ4GYyXWvDlDlRjZG",
  render_errors: [view: FooWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Foo.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

import_config "#{Mix.env()}.exs"
