defmodule BananaBankWeb.UserController do
  use BananaBankWeb, :controller
  alias BananaBank.Users.{CreateUser, GetUser, UpdateUser, DeleteUser, GetUserByEmail}
  alias BananaBankWeb.Token

  action_fallback BananaBankWeb.FallbackController

  def create(conn, params_request) do
    with {:ok, _user} <- CreateUser.execute(params_request) do
      conn
      |> put_status(201)
      |> put_resp_content_type("application/json")
      |> text("")
    end
  end

  def delete(conn, %{ "id" => id }) do
    with {:ok, _user} <- DeleteUser.execute(%{"id" => id}) do
      conn
      |> put_status(204)
      |> put_resp_content_type("application/json")
      |> text("")
    end
  end

  def login(conn, %{"email"=> email, "password" => password} = auth) do
    IO.inspect(auth)
    case BananaBank.Users.Verify.execute(%{"email" => email, "password" => password}) do
      true -> conn |> put_status(200) |> render(:auth_user, ok: generate_token(email))
      false -> conn |> put_status(401) |> render(:auth_user, error: "Unauthorized")
    end
  end

  defp generate_token(email) do
    with {:ok, user} <- GetUserByEmail.execute(email) do
      Token.sign(user)
    end
  end

  def show(conn, params) do
    with {:ok, user} <- GetUser.execute(params["id"]) do
      conn
      |> put_status(200)
      |> render(:show_user, user: user)
    end
  end

  def update(conn, params) do
    with {:ok, _user} <- UpdateUser.execute(params) do
      conn
      |> put_status(204)
      |> put_resp_content_type("application/json")
      |> text("")
    end
  end
end
