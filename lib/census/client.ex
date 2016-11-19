defmodule Census.Client do
  defstruct api_key: "", dataset: "SF1", vintage: "2010"

  @moduledoc """
  Struct representing an API client.
  """

  @type t :: %__MODULE__{}

  @doc """
  Create a new api client.

  Usage:

      iex> Census.Client.new("YOUR_API_KEY")
      %Census.Client{api_key: "YOUR_API_KEY", dataset: "SF1", vintage: "2010"}

  Clients default to the 2010 SF1 dataset. To set an alternate dataset and vintage:

      iex> Census.Client.new("YOUR_API_KEY", dataset: "ACS5", vintage: "2005")
      %Census.Client{api_key: "YOUR_API_KEY", dataset: "ACS5", vintage: "2005"}
  """
  @spec new(String.t, Keyword.t) :: __MODULE__.t
  def new(api_key, options \\ []) do
    struct(__MODULE__, Keyword.put(options, :api_key, api_key))
  end
end
