defmodule Census.Endpoint do
  def build(client, query) do
    "#{client_url(client)}&#{query_params(query)}"
  end

  defp client_url(%{api_key: api_key, vintage: vintage, dataset: dataset}) do
    "http://api.census.gov/data/#{vintage}/#{String.downcase(dataset)}?key=#{api_key}"
  end

  defp query_params(%{get: get, foreach: foreach, within: within}) do
    [:get, :for, :in]
    |> Enum.zip([get, foreach, within])
    |> Enum.reject(fn {_, v} -> v == nil || v == "" end)
    |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
    |> Enum.join("&")
  end
end
