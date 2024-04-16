defmodule BananaBank.Users.Verify do
  alias BananaBank.Users

  def execute(%{"email" => email, "password" => password}) do
    case Users.GetUserByEmail.execute(email) do
      {:ok, user} -> Argon2.verify_pass(password, user.password_hash)
      {:error, _} -> {:error, :not_found}
    end
  end
end
