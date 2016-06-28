defmodule Census do
  defdelegate fetch(client, params), to: Census.Adapter
end
