defmodule Census.Response do
  defstruct results: []

  def decode!(body) do
    results = body
    |> Poison.decode!
    |> extract_results

    struct(__MODULE__, results: results)
  end

  defp extract_results([keys | tail]) do
    Enum.map tail, fn (item) ->
      keys
      |> Enum.zip(item)
      |> Enum.into(%{})
    end
  end
end
