defmodule Census.FakeClientStore do
  alias Census.Endpoint

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def enqueue_response(client, query, response) do
    Agent.update __MODULE__, fn(state) ->
      Map.put(state, Endpoint.build(client, query), response)
    end
  end

  def get_response(client, query) do
    Agent.get __MODULE__, fn(state) ->
      state[Endpoint.build(client, query)]
    end
  end
end
