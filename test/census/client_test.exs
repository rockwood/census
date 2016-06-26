defmodule Census.ClientTest do
  use ExUnit.Case
  alias Census.Client

  describe "new/2" do
    test "sets default options" do
      assert %{api_key: "123", dataset: "SF1"} = Client.new("123")
    end

    test "allows overriding default options" do
      assert %{api_key: "123", dataset: "ACS5"} = Client.new("123", dataset: "ACS5")
    end
  end
end
