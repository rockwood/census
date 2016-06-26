defmodule CensusTest do
  use ExUnit.Case
  alias Census.{FakeClient, FakeClientStore, Query}
  doctest Census

  describe "fetch/2" do
    setup do
      client = FakeClient.new()
      query = Query.new(fields: "P0010001", level: "STATE:36")
      FakeClientStore.enqueue_response(query, File.read!("test/fixtures/ohio_pop.json"))
      {:ok, client: client, query: query}
    end

    test "returns a result", %{client: client, query: query} do
      {:ok, response} = Census.fetch(client, query)
      assert %{"state" => "36"} = hd(response.results)
    end
  end
end
