defmodule BananaBank.Users.GetUserByEmail do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def execute(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

end
