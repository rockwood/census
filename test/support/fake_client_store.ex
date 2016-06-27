defmodule Census.FakeClientStore do
  alias Census.Response

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def enqueue_response(query, response_body) do
    Agent.update __MODULE__, fn(state) ->
      Map.put(state, state_key(query), Response.decode!(response_body))
    end
  end

  def get_response(query) do
    Agent.get __MODULE__, fn(state) ->
      state[state_key(query)]
    end
  end

  defp state_key(query) do
    "#{query.fields}-#{query.level}"
  end
end
