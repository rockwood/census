defmodule CensusTest do
  use ExUnit.Case
  alias Census.{FakeClient, FakeClientStore, Query}
  doctest Census

  describe "fetch/2" do
    setup do
      client = FakeClient.new()
      query = Query.new(client, fields: "P0010001", level: "STATE:36")
      fake_response = %{status_code: 200, body: File.read!("test/fixtures/ohio_pop.json")}
      FakeClientStore.enqueue_response(query, fake_response)
      {:ok, client: client}
    end

    test "returns a result", %{client: client} do
      {:ok, response} = Census.fetch(client, fields: "P0010001", level: "STATE:36")
      assert %{"state" => "36"} = hd(response.results)
    end
  end
end
