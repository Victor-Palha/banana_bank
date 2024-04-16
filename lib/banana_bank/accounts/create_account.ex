defmodule BananaBank.Accounts.CreateAccount do
  alias BananaBank.Users.User
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo

  def execute(%{"user_id" => user_id} = params) do
    case Repo.get(User, user_id) do
      nil -> {:error, "User not found"}
      %User{} -> params |> Account.changeset() |> Repo.insert()
    end
  end
end
