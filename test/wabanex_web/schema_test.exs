defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns an user", %{conn: conn} do
      params = %{name: "Yoda", email: "yoda@thejedimaster.com", password: "900900"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            name,
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "yoda@thejedimaster.com",
            "name" => "Yoda"
          }
        }
      }

      assert response == expected_response
    end

    test "when an invalid id is given, returns an error", %{conn: conn} do
      params = %{name: "Yoda", email: "yoda@thejedimaster.com", password: "900900"}

      Create.call(params)

      query = """
        {
          getUser(id: "test-id") {
            name,
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 13, "line" => 2}],
            "message" => "Argument \"id\" has invalid value \"test-id\"."
          }
        ]
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates an user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input:{
            name: "Darth Vader",
            email: "darthvader@thechoosenone.com",
            password: "imyourfather"
          }) {
            id,
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "createUser" => %{
                   "id" => _id,
                   "name" => "Darth Vader"
                 }
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input:{
            name: "Darth Vader",
            email: "darthvaderthechoosenone.com",
            password: "imyourfather"
          }) {
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"createUser" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "email has invalid format",
            "path" => ["createUser"]
          }
        ]
      }

      assert response == expected_response
    end
  end
end
