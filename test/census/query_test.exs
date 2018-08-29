defmodule Census.QueryTest do
  use ExUnit.Case
  alias Census.{Query, Client}
  doctest Census.Query

  describe "url/1" do
    setup do
      client = %Client{api_key: "API_KEY", vintage: 2000, dataset: "DATASET"}
      query = %Query{client: client, get: "FIELDS", foreach: "STATE:01", within: "COUNTY:02"}
      {:ok, client: client, query: query}
    end

    test "it returns the correct endpoint", %{query: query} do
      endpoint = Query.url(query)
      assert endpoint =~ "/2000/dec/dataset?key=API_KEY&get=FIELDS&for=STATE:01&in=COUNTY:02"
    end

    test "it filters unused params", %{query: query} do
      endpoint = Query.url(Map.put(query, :within, nil))
      refute String.contains?(endpoint, "in=")
    end
  end
end
