defmodule Census.HttpAdapter do
  @behaviour Census.Adapter

  alias Census.{Query, Response}

  @connect_options [
    timeout: 30_000,
    connect_timeout: 30_000,
    recv_timeout: 30_000,
  ]

  def fetch(client, params) do
    query = Query.new(client, params)
    query
    |> Query.url
    |> HTTPoison.get([], @connect_options)
    |> case do
      {:ok, response} -> Response.decode(query, response)
      {:error, error} -> {:error, to_string(error.reason)}
    end
  end
end
