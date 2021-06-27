defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "when all params are valid, returns IMC info", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Dani" => 25.71166207529844,
          "Diego" => 23.37472607742878,
          "Guilherme" => 31.884366032522056,
          "Mayk" => 25.30864197530864,
          "Rafael" => 24.897060231734173,
          "Thomaz" => 23.75
        }
      }

      assert response == expected_response
    end

    test "when there are invalid parameters, returns an error", %{conn: conn} do
      params = %{"filename" => "batata.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error while opening the file"}

      assert response == expected_response
    end
  end
end
