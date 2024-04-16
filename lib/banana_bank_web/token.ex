defmodule BananaBankWeb.Token do
  alias BananaBankWeb.Endpoint

  @sign_salt "banana_token"
  def sign(user) do
    Phoenix.Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token), do: Phoenix.Token.verify(Endpoint, @sign_salt, token)
end
