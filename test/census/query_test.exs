defmodule Census.QueryTest do
  use ExUnit.Case
  alias Census.{Query, Client}

  describe "url/1" do
    setup do
      client = Client.new("API_KEY", vintage: 2000, dataset: "DATASET")
      query = Query.new(client, get: "FIELDS", foreach: "STATE:01", within: "COUNTY:02")
      {:ok, client: client, query: query}
    end

    test "it returns the correct endpoint", %{query: query} do
      endpoint = Query.url(query)
      assert endpoint =~ "/2000/dataset?key=API_KEY&get=FIELDS&for=STATE:01&in=COUNTY:02"
    end

    test "it filters unused params", %{query: query} do
      endpoint = Query.url(Map.put(query, :within, nil))
      refute String.contains?(endpoint, "in=")
    end
  end
end
