defmodule BananaBankWeb.Plugs.Auth do
  import Plug.Conn
  alias BananaBankWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
            conn = assign(conn, :user_id, data.user_id)
        else
          _error ->
            conn
            |> put_status(401)
            |> Phoenix.Controller.put_view(BananaBankWeb.ErrorJSON)
            |> Phoenix.Controller.render(:error, status: 401)
            |> halt()
        end

  end
end
