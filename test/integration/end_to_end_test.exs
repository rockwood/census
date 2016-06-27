defmodule Census.EndToEndTest do
  use ExUnit.Case
  alias Census.{Client, Query}

  @moduletag :integration
  @api_key System.get_env("CENSUS_API_KEY")

  describe "fetch/2" do
    setup do
      client = Client.new(@api_key)
      query = Query.new(fields: "P0010001", level: "STATE:01")
      {:ok, client: client, query: query}
    end

    test "returns a result", %{client: client, query: query} do
      {:ok, response} = Census.fetch(client, query)
      assert %{"state" => "01"} = hd(response.results)
    end
  end
end
