defmodule Census do
  defdelegate client(api_key, options \\ []), to: Census.Client, as: :new

  def fetch(client, params) do
    Application.get_env(:census, :adapter).fetch(client, params)
  end
end
