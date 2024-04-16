defmodule BananaBankWeb.UserControllerTest do
  use BananaBankWeb.ConnCase
  alias BananaBank.Users.CreateUser
  alias BananaBank.Users.User

  import Mox
  setup :verify_on_exit!


  @default_user_test %{
    "name" => "John Doe",
    "email" => "john@test.com",
    "password" => "123456",
    "cep" => "66083443"
  }
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

  describe "POST /users" do
    test "create a new user", %{conn: conn} do

      expect(BananaBank.ViaCep.ClientMock, :get_cep, fn "66083443" ->
        {:ok, @default_mock_response}
      end)

      %{status: status} =
        conn
        |> post(~p"/api/users", @default_user_test)

      assert status == 201
    end

    test "failure to create a new user without cep", %{conn: conn} do
      params = %{
          name: "John Doe",
          email: "john@test.com",
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(400)

      assert %{
        "errors" => %{
          "password" => [
            "can't be blank"
          ],
          "cep" => [
            "can't be blank"
          ]
        }
      } == response

    end

    test "failure to create a new user with invalid cep", %{conn: conn} do
      params = %{
        name: "John Doe",
        email: "john@test.com",
        cep: "00000000",
        password: "123456"
      }

      expect(BananaBank.ViaCep.ClientMock, :get_cep, fn "00000000" ->
        {:error, :not_found}
      end)

      _response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(404)
    end
  end

  describe "GET /users/someID" do
    test "Get Some User by ID", %{conn: conn} do

      expect(BananaBank.ViaCep.ClientMock, :get_cep, fn "66083443" ->
        {:ok, @default_mock_response}
      end)

      {:ok, %User{id: id}} = CreateUser.execute(@default_user_test)

      response =
        conn
        |> get(~p"/api/users/#{id}")
        |> json_response(200)


      expected_response = %{
        "user" => %{
          "name" => "John Doe",
          "cep" => "66083443",
          "email" => "john@test.com"
        }
      }

      assert response == expected_response

    end
  end

  describe "DELETE /users/someID" do
    test "Delete Some User by ID", %{conn: conn} do
      expect(BananaBank.ViaCep.ClientMock, :get_cep, fn "66083443" ->
        {:ok, @default_mock_response}
      end)

      {:ok, %User{id: id}} = CreateUser.execute(@default_user_test)

      %{status: status} =
        conn
        |> delete(~p"/api/users/#{id}")

      assert status == 204
    end
  end

  describe "UPDATE /users/someID" do
    test "Update Some User by ID", %{conn: conn} do
      params_update = %{
        "email" => "john2@gmail.com"
      }

      expect(BananaBank.ViaCep.ClientMock, :get_cep, fn "66083443" ->
        {:ok, @default_mock_response}
      end)

      {:ok, %User{id: id}} = CreateUser.execute(@default_user_test)

      %{status: status} =
        conn
        |> put(~p"/api/users/#{id}", params_update)

      assert status == 204
    end
  end
end
