# Usage

```
%> mkdir priv
%> curl -o priv/airports.csv https://davidmegginson.github.io/ourairports-data/airports.csv
%> iex -S mix
```

```elixir
iex> {time, _ } = :timer.tc(&Airports.open_airports/0)
iex> time / 1_000_000
```