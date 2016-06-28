defmodule Census.EndpointTest do
  use ExUnit.Case
  alias Census.{Endpoint, Client, Query}

  describe "build/2" do
    setup do
      client = Client.new("API_KEY", vintage: 2000, dataset: "DATASET")
      query = Query.new(fields: "FIELDS", level: "STATE:01", within: "COUNTY:02")
      {:ok, client: client, query: query}
    end

    test "it returns the correct endpoint", %{client: client, query: query} do
      endpoint = Endpoint.build(client, query)
      assert endpoint =~ "/2000/dataset?key=API_KEY&get=FIELDS&for=STATE:01&in=COUNTY:02"
    end

    test "it filters unused params", %{client: client, query: query} do
      endpoint = Endpoint.build(client, Map.put(query, :within, nil))
      refute String.contains?(endpoint, "in=")
    end
  end
end
