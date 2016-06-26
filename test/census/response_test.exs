defmodule Census.ResponseTest do
  use ExUnit.Case
  alias Census.Response

  describe "decode!/1" do
    test "returns results" do
      body = "[[\"P0010001\",\"state\"],\n[\"3831074\",\"41\"]]"
      response = Response.decode!(body)
      assert [%{"P0010001" => "3831074", "state" => "41"}] = response.results
    end
  end
end
