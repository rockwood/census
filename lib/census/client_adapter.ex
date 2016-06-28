defimpl Census.Adapter, for: Census.Client do
  alias Census.{Query, Endpoint, Response}

  @connect_options [
    timeout: 30_000,
    connect_timeout: 30_000,
    recv_timeout: 30_000,
  ]

  def fetch(client, params) do
    query = Query.new(client, params)
    case HTTPoison.get(Query.url(query), [], @connect_options) do
      {:ok, response} -> Response.decode(response)
      {_, error} -> {:error, to_string(error.reason)}
    end
  end
end
