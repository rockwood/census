defmodule Census.Query do
  defstruct client: %Census.Client{}, get: "", foreach: "", within: ""

  @moduledoc """
  Struct representing an API query.
  """

  @type t :: %__MODULE__{}

  @doc """
  Returns the api url for a given query.

  Usage:

      iex> client = %Census.Client{api_key: "YOUR_API_KEY"}
      iex> query = %Census.Query{client: client, get: "NAME", foreach: "COUNTY:*", within: "STATE:55"}
      iex> Census.Query.url(query)
      "https://api.census.gov/data/2010/dec/sf1?key=YOUR_API_KEY&get=NAME&for=COUNTY:*&in=STATE:55"
  """

  @spec url(__MODULE__.t()) :: String.t()
  def url(query) do
    "#{endpoint(query)}?#{params(query)}"
  end

  defp endpoint(%{client: %{vintage: vintage, program: program, dataset: dataset}}) do
    "https://api.census.gov/data/#{vintage}/#{program}/#{String.downcase(dataset)}"
  end

  defp params(%{client: %{api_key: api_key}, get: get, foreach: foreach, within: within}) do
    [:key, :get, :for, :in]
    |> Enum.zip([api_key, get, foreach, within])
    |> Enum.reject(fn {_, v} -> v == nil || v == "" end)
    |> Enum.map(fn {k, v} -> "#{k}=#{v}" end)
    |> Enum.join("&")
  end
end
