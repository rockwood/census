defmodule Census.ResponseTest do
  use ExUnit.Case
  alias Census.Response

  describe "decode!/1" do
    test "with a valid response, it returns results" do
      {:ok, response} = Response.decode(%{status_code: 200, body: "[[\"P0010001\",\"state\"],\n[\"3831074\",\"41\"]]"})
      assert [%{"P0010001" => "3831074", "state" => "41"}] = response.results
    end

    test "with a 302, it returns an unauthorized message" do
      {:error, reason} = Response.decode(%{status_code: 302, body: ""})
      assert reason =~ "check your API key"
    end

    test "with an invalid response, it returns the error" do
      {:error, reason} = Response.decode(%{status_code: 500, body: "uh oh"})
      assert reason =~ "500 - uh oh"
    end

    test "with malformed json, it returns an error" do
      {:error, reason} = Response.decode(%{status_code: 200, body: "not json"})
      assert reason =~ "invalid response - not json"
    end
  end
end
