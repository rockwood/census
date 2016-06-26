defimpl Census.Adapter, for: Census.Client do
  def fetch(client, query) do
    case HTTPoison.get(endpoint(client), [], params: params(client, query), recv_timeout: 10000) do
      {200, response} -> {:ok, response}
    end
  end

  defp endpoint(%{vintage: vintage, dataset: dataset}) do
    "http://api.census.gov/data/#{vintage}/#{String.downcase(dataset)}"
  end

  defp params(%{api_key: api_key}, %{fields: fields, level: level}) do
    %{
      key: api_key,
      get: fields,
      for: level
    }
  end
end
