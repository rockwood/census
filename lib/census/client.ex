defmodule Census.Client do
  defstruct api_key: "", dataset: "SF1", program: "dec", vintage: "2010"

  @moduledoc """
  Struct representing an API client.
  """

  @type t :: %__MODULE__{}
end
