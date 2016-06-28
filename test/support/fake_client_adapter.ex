defimpl Census.Adapter, for: Census.FakeClient do
  alias Census.{FakeClientStore, Query, Response}

  def fetch(client, params) do
    query = Query.new(client, params)
    response = FakeClientStore.get_response(query)
    Response.decode(response)
  end
end
