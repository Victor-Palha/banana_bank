defmodule BananaBankWeb.UserJSON do
  alias BananaBank.Users.User

  def create_user(%{user: _user}) do
    %{}
  end

  def show_user(%{user: user}) do
    %{
      user: data(user)
    }
  end

  def auth_user(%{ok: token}) do
    %{
      token: token
    }
  end

  def auth_user(%{error: _error}) do
    %{
      error: "Email or password invalid!"
    }
  end

  defp data(%User{} = user) do
    %{
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
