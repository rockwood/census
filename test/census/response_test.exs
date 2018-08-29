defmodule Census.ResponseTest do
  use ExUnit.Case
  alias Census.Response
  doctest Census.Response

  describe "decode!/1" do
    setup do
      {:ok, query: %Census.Query{}}
    end

    test "with a valid response, it returns results", %{query: query} do
      {:ok, response} =
        Response.decode(query, %{
          status_code: 200,
          body: "[[\"H010001\",\"state\"],\n[\"3831074\",\"41\"]]"
        })

      assert [%{"H010001" => "3831074", "state" => "41"}] = response.results
    end

    test "with a 302, it returns an unauthorized message", %{query: query} do
      {:error, reason} = Response.decode(query, %{status_code: 302, body: ""})
      assert reason =~ "check your API key"
    end

    test "with an invalid response, it returns the error", %{query: query} do
      {:error, reason} = Response.decode(query, %{status_code: 500, body: "uh oh"})
      assert reason =~ "500 - uh oh"
    end

    test "with malformed json, it returns an error", %{query: query} do
      {:error, reason} = Response.decode(query, %{status_code: 200, body: "not json"})
      assert reason =~ "Invalid response - not json"
    end
  end
end
