defimpl Census.Adapter, for: Census.Client do
  alias Census.{Endpoint, Response}

  def fetch(client, query) do
    case HTTPoison.get(Endpoint.build(client, query), [], recv_timeout: 30_000) do
      {:ok, response} -> Response.decode(response)
      {_, error} -> {:error, to_string(error.reason)}
    end
  end
end
