defmodule Census.Adapter do
  @callback fetch(Census.Client.t(), Keyword.t()) ::
              {:ok, Census.Response.t()} | {:error, String.t()}
end
