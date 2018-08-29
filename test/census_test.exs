defmodule CensusTest do
  use ExUnit.Case
  alias Census.{Client, FakeAdapter, Query}
  doctest Census

  setup do
    Application.put_env(:census, :adapter, Census.FakeAdapter)
  end

  describe "fetch/2" do
    setup do
      client = %Client{}
      query = Query.new(client, fields: "H010001", level: "STATE:36")
      fake_response = %{status_code: 200, body: File.read!("test/fixtures/ohio_pop.json")}
      FakeAdapter.enqueue_response(query, fake_response)
      {:ok, client: client}
    end

    test "returns a result", %{client: client} do
      {:ok, response} = Census.fetch(client, fields: "H010001", level: "STATE:36")
      assert %{"state" => "36"} = hd(response.results)
    end
  end
end
