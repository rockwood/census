defmodule Census.Client do
  defstruct api_key: "", dataset: "SF1", vintage: "2010"

  def new(api_key, options \\ []) do
    struct(__MODULE__, Keyword.put(options, :api_key, api_key))
  end
end
