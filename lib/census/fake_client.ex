defmodule Census.FakeClient do
  defstruct dataset: "SF1", vintage: "2010"

  def new(options \\ []) do
    struct(__MODULE__, options)
  end
end
