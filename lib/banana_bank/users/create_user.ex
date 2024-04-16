defmodule BananaBank.Users.CreateUser do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep.Client

  def execute(%{"cep" => cep} = user) do
    with {:ok, _body} <- client().get_cep(cep) do
      user
      |> User.changeset()
      |> Repo.insert()
    end
  end

  def execute(user), do: user |> User.changeset() |> Repo.insert()

  defp client() do
    Application.get_env(:banana_bank, :via_cep_client, Client)
  end
end
