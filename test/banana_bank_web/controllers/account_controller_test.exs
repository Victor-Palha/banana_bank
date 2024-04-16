defmodule BananaBankWeb.AccountControllerTest do
  use BananaBankWeb.ConnCase
  alias BananaBank.Users.CreateUser
  alias BananaBank.Users.User

  import Mox
  setup :verify_on_exit!

  @default_mock_response %{
    "bairro" => "Pedreira",
    "cep" => "66083-443",
    "complemento" => "de 970/971 a 1336/1337",
    "ddd" => "91",
    "gia" => "",
    "ibge" => "1501402",
    "localidade" => "Belém",
    "logradouro" => "Rua Nova",
    "siafi" => "0427",
    "uf" => "PA"
  }

  setup do
    user_test =  %{
      "name" => "John Doe",
      "email" => "john@test.com",
      "password" => "123456",
      "cep" => "66083443"
    }

    expect(BananaBank.ViaCep.ClientMock, :get_cep, fn "66083443" ->
      {:ok, @default_mock_response}
    end)

    {:ok, %User{id: id}} = CreateUser.execute(user_test)
    {:ok, id: id}
  end

  describe "POST /accounts" do
    test "creates an account", %{conn: conn, id: id} do

      params = %{
        "user_id" => id,
        "balance" => 100
      }

      %{status: status} =
        conn
        |> post(~p"/api/accounts", params)

      assert status == 201
    end
  end
end
