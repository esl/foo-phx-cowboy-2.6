defmodule FooWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :foo

  socket("/socket", FooWeb.UserSocket)

  plug(Plug.Static, at: "/", from: :foo, gzip: false, only: ~w(css fonts images js favicon.ico robots.txt))

  if code_reloading? do
    socket("/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket)
    plug(Phoenix.LiveReloader)
    plug(Phoenix.CodeReloader)
  end

  plug(Plug.Logger)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
  )

  plug(Plug.MethodOverride)
  plug(Plug.Head)

  plug(Plug.Session,
    store: :cookie,
    key: "_foo_key",
    signing_salt: "tSyoDesJ"
  )

  plug(FooWeb.Router)

  def init(_key, config) do
    Confex.Resolver.resolve(config)
  end
end
