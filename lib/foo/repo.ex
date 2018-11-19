defmodule Foo.Repo do
  use Ecto.Repo, otp_app: :foo

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, config) do
    Foo.ReleaseTasks.resolve_config config
  end
end
