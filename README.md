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
%Census.Client{api_key: YOUR_API_KEY, dataset: "SF1", vintage: 2010}
```

Clients will default to the 2010 SF1 dataset. Other datasets are available at 
[census.gov](http://www.census.gov/data/developers/data-sets.html)

### Fetch

```elixir
iex> {:ok, response} = Census.fetch(client, get: "NAME,P0010001", foreach: "COUNTY:*", within: "STATE:55")
iex> response.results
[%{"NAME" => "Adams County", "P0010001" => "20875", ...}]
```

Here, we're querying the total population for each county in Wisconsin. Documentation for available
query parameters can be found at [api.census.gov/data.html](http://api.census.gov/data.html)

This library makes no attempt to coarse returned values. Almost everything is returned as a string, 
so you'll need to implement you're own coercion if necessary.

## License

This software is licensed under [Apache 2 License](LICENSE).



