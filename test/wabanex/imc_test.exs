defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_reponse =
        {:ok,
         %{
           "Dani" => 25.71166207529844,
           "Diego" => 23.37472607742878,
           "Guilherme" => 31.884366032522056,
           "Mayk" => 25.30864197530864,
           "Rafael" => 24.897060231734173,
           "Thomaz" => 23.75
         }}

      assert response == expected_reponse
    end

    test "when the wrong filename is given, returns an error" do
      params = %{"filename" => "batata.csv"}

      response = IMC.calculate(params)

      expected_reponse = {:error, "Error while opening the file"}

      assert response == expected_reponse
    end
  end
end
