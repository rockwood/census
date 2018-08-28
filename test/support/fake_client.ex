defmodule Census.FakeClient do
  defstruct api_key: "", dataset: "SF1", program: "dec", vintage: "2010"

  def new(options \\ []) do
    struct(__MODULE__, options)
  end
end
