defmodule Census.FakeClientStore do
  alias Census.Query

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def enqueue_response(query, response) do
    Agent.update __MODULE__, fn(state) ->
      Map.put(state, Query.url(query), response)
    end
  end

  def get_response(query) do
    Agent.get __MODULE__, fn(state) ->
      state[Query.url(query)]
    end
  end
end
