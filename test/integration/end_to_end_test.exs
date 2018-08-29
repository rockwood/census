defmodule Census.EndToEndTest do
  use ExUnit.Case
  alias Census.{Client}

  @moduletag :integration

  setup do
    Application.put_env(:census, :adapter, Census.HttpAdapter)
  end

  describe "fetch/2" do
    setup do
      client = %Client{api_key: System.get_env("CENSUS_API_KEY")}
      {:ok, client: client}
    end

    test "returns a result", %{client: client} do
      params = [get: "NAME,H010001", foreach: "COUNTY:*", within: "STATE:55"]
      {:ok, response} = Census.fetch(client, params)
      assert %{"NAME" => "Green County, Wisconsin"} = hd(response.results)
    end
  end
end
