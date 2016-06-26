defmodule Census.Query do
  defstruct fields: "", level: "", within: ""

  def new(attrs) do
    struct(__MODULE__, attrs)
  end
end
