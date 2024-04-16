defmodule BananaBankWeb.AccountController do
  use BananaBankWeb, :controller
  alias BananaBank.Accounts.{CreateAccount, Transaction, Account}

  action_fallback BananaBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %Account{} = _account} <- CreateAccount.execute(params) do
      conn
      |> put_status(201)
      |> put_resp_content_type("application/json")
      |> text("")
    end
  end

  def transaction(conn, %{"from_account" => from_account, "to_account" => to_account, "value" => value}) do
    with {:ok, _transaction} <- Transaction.execute(from_account, to_account, value) do
      conn
      |> put_status(200)
      |> put_resp_content_type("application/json")
      |> text("")
    end
  end
end
