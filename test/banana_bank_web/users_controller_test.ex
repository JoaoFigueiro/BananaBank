defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users
  alias User.User

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      params = %{
        name: "João",
        cep: "12345678",
        email: "joao@frutas.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p/api/users, params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "cep" => "123456678",
                 "email" => "joao@frutas.com",
                 "id" => _id,
                 "name" => "João"
               },
               "message" => "User criado com sucesso!"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = %{
        name: nil,
        cep: "12",
        email: "joao@frutas.com",
        password: "123456"
      }

      response =
        conn
        |> post(~p/api/users, params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "cep" => ["should be 8 character(s)"],
          "name" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "successfully delete an user", %{conn: conn} do
      params = %{
        name: "João",
        cep: "12345678",
        email: "joao@frutas.com",
        password: "123456"
      }

      {:ok, %User{id: id}} = Users.create(params)

      response =
        conn
        |> delete(~p"/api/users/#{id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "cep" => "12345678",
          "email" => "joao@frutas.com",
          "id" => id,
          "name" => "João"
        }
      }

      assert response == expected_response
    end
  end
end
