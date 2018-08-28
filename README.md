# Census

Elixir library for interacting with the [US Census API](http://api.census.gov)

## Installation

Add `census` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:census, "~> 0.1.0"}]
end

def application do
  [applications: [:census]]
end
```

## Usage

Get an api key at [api.census.gov/data/key_signup.html](http://api.census.gov/data/key_signup.html).

### Create a client

```elixir
iex> client = Census.client(YOUR_API_KEY, dataset: "SF1", vintage: 2010)
```

Clients will default to the 2010 SF1 dataset. Other datasets are available at
[census.gov](http://www.census.gov/data/developers/data-sets.html)

### Query the api

Here, we're querying the total population for each county in Wisconsin. Documentation for available
query parameters can be found at [api.census.gov/data.html](http://api.census.gov/data.html)

```elixir
iex> {:ok, resp} = Census.fetch(client, get: "NAME,H010001", foreach: "COUNTY:*", within: "STATE:55")
iex> resp.results
[%{"NAME" => "Adams County", "H010001" => "20875", ...}]
```

This library makes no attempt to coerce returned values. Almost everything is returned as a string,
so you'll need to implement your own coercion if necessary.

## License

This software is licensed under the [Apache 2 License](LICENSE).
