# Usage

```
%> mkdir priv
%> curl -o priv/airports.csv https://davidmegginson.github.io/ourairports-data/airports.csv
%> mix run lib/airports.exs
```

# Output

```
Benchmarking flow ...
Benchmarking naive ...
Benchmarking stream ...

Name             ips        average  deviation         median         99th %
flow            9.39      106.54 ms     ±1.26%      106.38 ms      109.38 ms
stream          3.66      273.31 ms     ±0.75%      273.07 ms      277.49 ms
naive           0.79     1270.82 ms    ±14.67%     1270.07 ms     1486.82 ms
```