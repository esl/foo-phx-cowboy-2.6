defmodule Foo.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Foo.Repo, []),
      supervisor(FooWeb.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Foo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    FooWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
