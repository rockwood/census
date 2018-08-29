defmodule Census do
  alias Census.Client

  @doc """
  Create a new api client.

  Usage:

      iex> Census.client("YOUR_API_KEY")
      %Census.Client{api_key: "YOUR_API_KEY", dataset: "SF1", vintage: "2010"}

  Clients default to the 2010 SF1 dataset. To set an alternate dataset and vintage:

      iex> Census.client("YOUR_API_KEY", dataset: "ACS5", vintage: "2005")
      %Census.Client{api_key: "YOUR_API_KEY", dataset: "ACS5", program: "dec", vintage: "2005"}
  """
  @spec client(String.t(), Keyword.t()) :: Client.t()
  def client(api_key, options \\ []) do
    struct!(Client, Keyword.put(options, :api_key, api_key))
  end

  @doc """
  Make a census api request given a client and query parameters.

  Params:

    * `get`
    * `foreach`
    * `within` (optional)

  Usage:

      iex> client = Census.client("YOUR_API_KEY")
      iex> {:ok, response} = Census.fetch(client, get: "NAME", foreach: "COUNTY:*", within: "STATE:*")
      iex> response.results
      [%{}]
  """

  def fetch(client, params) do
    Application.get_env(:census, :adapter).fetch(client, params)
  end
end
