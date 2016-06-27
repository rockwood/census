defimpl Census.Adapter, for: Census.FakeClient do
  def fetch(_client, query) do
    {:ok, Census.FakeClientStore.get_response(query)}
  end
end
