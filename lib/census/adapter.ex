defprotocol Census.Adapter do
  @moduledoc """
  Protocol for implementing adapters for different client types
  """

  @doc """
  Make a census api request given a client and query parameters.

  Params:

    * `get`
    * `foreach`
    * `within` (optional)

  Usage:

      iex> client = Census.Client.new("YOUR_API_KEY")
      iex> {:ok, response} = Census.Adapter.fetch(client, get: "NAME", foreach: "COUNTY:*", within: "STATE:*")
  """
  @spec fetch(client :: Census.Client.t, params :: Keyword.t) :: {:ok, Census.Response.t}
                                                               | {:error, String.t}
  def fetch(client, params)
end
