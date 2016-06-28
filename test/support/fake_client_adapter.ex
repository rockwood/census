defimpl Census.Adapter, for: Census.FakeClient do
  alias Census.{FakeClientStore, Response}
  def fetch(client, query) do
    response = FakeClientStore.get_response(client, query)
    Response.decode(response)
  end
end
