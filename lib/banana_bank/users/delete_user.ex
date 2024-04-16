defmodule BananaBank.Users.DeleteUser do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def execute(%{"id" => id}) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> delete(user)
    end
  end

  defp delete(user) do
    user
    |> Repo.delete()
    |> case do
      {:ok, user} -> {:ok, user}
      {:error, changeset} -> {:error, changeset}
    end
  end

end
