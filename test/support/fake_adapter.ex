defmodule Census.FakeAdapter do
  @behaviour Census.Adapter

  alias Census.{Query, Response}

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def enqueue_response(query, response) do
    Agent.update(__MODULE__, &Map.put(&1, Query.url(query), response))
  end

  @impl true
  def fetch(client, params) do
    query = Query.new(client, params)
    Response.decode(query, get_response(query))
  end

  defp get_response(query) do
    default_response = %{status_code: 200, body: "[[], []]"}
    Agent.get(__MODULE__, &Map.get(&1, Query.url(query), default_response))
  end
end
