defmodule CensusTest do
  use ExUnit.Case
  doctest Census

  describe "fetch/2" do
    test "returns a result" do
      client = Census.FakeClient.new()
      {:ok, result} = Census.fetch(client, %{fields: "P0010001,NAME", level: "STATE:41"})
      assert result
    end
  end
end
