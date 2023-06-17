Benchee.run(%{
  naive: &Airports.open_airports/0,
  stream: &Airports.open_airports_stream/0
})
