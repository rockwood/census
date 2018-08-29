defmodule Census.Response do
  defstruct query: %Census.Query{}, results: []
  @type t :: %__MODULE__{query: Census.Query.t(), results: []}

  @moduledoc """
  Struct representing an API response.
  """

  @doc """
  Process a query and api response.
  """

  @spec decode(Census.Query.t(), map) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def decode(query, %{status_code: 200, body: body}) do
    case Poison.decode(body) do
      {:ok, json} -> {:ok, struct(__MODULE__, query: query, results: extract_results(json))}
      {:error, _} -> {:error, "Invalid response - #{body}"}
    end
  end

  def decode(_query, %{status_code: 302, body: _body}) do
    {:error, "302 - Not authorized. Please check your API key."}
  end

  def decode(_query, %{status_code: status_code, body: body}) do
    {:error, "#{status_code} - #{body}"}
  end

  defp extract_results([keys | tail]) do
    Enum.map(tail, fn item ->
      keys
      |> Enum.zip(item)
      |> Enum.into(%{})
    end)
  end
end
