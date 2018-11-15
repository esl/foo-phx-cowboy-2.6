defmodule FooWeb.PageController do
  use FooWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
