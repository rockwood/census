defmodule Census.Adapter do
  @callback run(Census.Query.t()) :: {:ok, Census.Response.t()} | {:error, String.t()}
end
