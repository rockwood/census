defmodule Census.FakeAdapter do
  @behaviour Census.Adapter

  alias Census.{Query, Response}

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def enqueue_response(query, response) do
    Agent.update __MODULE__, fn(state) ->
      Map.put(state, Query.url(query), response)
    end
  end

  @impl true
  def fetch(client, params) do
    query = Query.new(client, params)
    Response.decode(query, get_response(query))
  end

  defp get_response(query) do
    Agent.get __MODULE__, fn(state) ->
      Map.get(state, Query.url(query), %{status_code: 200, body: "[[], []]"})
    end
  end
end
