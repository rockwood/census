defmodule Census do
  defdelegate fetch(client, query), to: Census.Adapter
end
