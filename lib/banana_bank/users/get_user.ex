defmodule BananaBank.Users.GetUser do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def execute(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

end
