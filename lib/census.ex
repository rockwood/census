defmodule Census do
  defdelegate client(api_key, options \\ []), to: Census.Client, as: :new
  defdelegate fetch(client, params), to: Census.Adapter
end
