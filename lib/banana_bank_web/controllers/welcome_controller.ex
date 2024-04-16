defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def execute(conn, params) do
    IO.inspect(conn)
    IO.inspect(params)

    json(conn, %{:wello => "horld"})
  end
end
