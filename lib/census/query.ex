defmodule Census.Query do
  defstruct get: "", foreach: "", within: ""

  def new(attrs) do
    struct(__MODULE__, attrs)
  end
end
