Benchee.run(%{
  flow: &Airports.open_airports_flow/0,
  naive: &Airports.open_airports/0,
  stream: &Airports.open_airports_stream/0
})
