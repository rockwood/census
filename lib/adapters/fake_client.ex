defimpl Census.Adapter, for: Census.FakeClient do
  def fetch(_client, _query) do
    {:ok, %{type: "fake"}}
  end
end
