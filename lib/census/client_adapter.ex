defimpl Census.Adapter, for: Census.Client do
  alias Census.{Endpoint, Response}

  @connect_options [
    timeout: 30_000,
    connect_timeout: 30_000,
    recv_timeout: 30_000,
  ]

  def fetch(client, query) do
    case HTTPoison.get(Endpoint.build(client, query), [], @connect_options) do
      {:ok, response} -> Response.decode(response)
      {_, error} -> {:error, to_string(error.reason)}
    end
  end
end
