# Usage

```
%> mkdir priv
%> curl -o priv/airports.csv https://davidmegginson.github.io/ourairports-data/airports.csv
%> mix run lib/airports.exs
```

# Output

```
Benchmarking naive ...
Benchmarking stream ...

Name             ips        average  deviation         median         99th %
stream          3.78         0.26 s     ±0.69%         0.26 s         0.27 s
naive           0.88         1.14 s    ±18.52%         1.04 s         1.51 s
```