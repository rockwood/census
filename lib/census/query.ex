defmodule Census.Query do
  defstruct client: %Census.Client{}, get: "", foreach: "", within: ""

  def new(client, params) do
    struct(__MODULE__, Keyword.put(params, :client, client))
  end

  def url(query) do
    "#{endpoint(query)}?#{params(query)}"
  end

  defp endpoint(%{client: %{vintage: vintage, dataset: dataset}}) do
    "http://api.census.gov/data/#{vintage}/#{String.downcase(dataset)}"
  end

  defp params(%{client: %{api_key: api_key}, get: get, foreach: foreach, within: within}) do
    [:key, :get, :for, :in]
    |> Enum.zip([api_key, get, foreach, within])
    |> Enum.reject(fn {_, v} -> v == nil || v == "" end)
    |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
    |> Enum.join("&")
  end
end
