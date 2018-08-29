defmodule Census.Query do
  defstruct client: %Census.Client{}, get: "", foreach: "", within: ""

  @moduledoc """
  Struct representing an API query.
  """

  @type t :: %__MODULE__{}

  @doc """
  Create a new query.

  Usage:

      iex> client = %Census.Client{api_key: "YOUR_API_KEY"}
      iex> Census.Query.new(client, get: "NAME,H010001", foreach: "COUNTY:*", within: "STATE:55")
      %Census.Query{
        client: %Census.Client{api_key: "YOUR_API_KEY", dataset: "SF1", vintage: "2010"},
        foreach: "COUNTY:*",
        get: "NAME,H010001",
        within: "STATE:55"
      }
  """

  @spec new(Census.Client.t(), Keyword.t()) :: Census.Query.t()
  def new(client, params) do
    struct(__MODULE__, Keyword.put(params, :client, client))
  end

  @doc """
  Returns the api url for a given query.

  Usage:

      iex> client = %Census.Client{api_key: "YOUR_API_KEY"}
      iex> query = Census.Query.new(client, get: "NAME", foreach: "COUNTY:*", within: "STATE:55")
      iex> Census.Query.url(query)
      "https://api.census.gov/data/2010/dec/sf1?key=YOUR_API_KEY&get=NAME&for=COUNTY:*&in=STATE:55"
  """

  @spec url(Census.Query.t()) :: String.t()
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
