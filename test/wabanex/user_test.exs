defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params arre valid, returns a valid changeset" do
      params = %{name: "Yoda", email: "yoda@thejedimaster.com", password: "900900"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{email: "yoda@thejedimaster.com", name: "Yoda", password: "900900"},
               errors: []
             } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{name: "Y", email: "yodathejedimaster.com"}

      response = User.changeset(params)

      expected_response = %{
        email: ["has invalid format"],
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
