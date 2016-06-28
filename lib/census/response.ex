defmodule Census.Response do
  defstruct results: []

  def decode(%{status_code: 200, body: body}) do
    case Poison.decode(body) do
      {:ok, json} -> {:ok, struct(__MODULE__, results: extract_results(json))}
      {:error, {:invalid, _}} -> {:error, "invalid response - #{body}"}
      {:error, :invalid} -> {:error, "invalid response - #{body}"}
    end
  end
  def decode(%{status_code: 302, body: _body}) do
    {:error, "302 - Not authorized. Please check your API key."}
  end
  def decode(%{status_code: status_code, body: body}) do
    {:error, "#{status_code} - #{body}"}
  end

  defp extract_results([keys | tail]) do
    Enum.map tail, fn (item) ->
      keys
      |> Enum.zip(item)
      |> Enum.into(%{})
    end
  end
end
