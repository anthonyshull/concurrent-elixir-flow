defmodule Airports do
  alias NimbleCSV.RFC4180, as: CSV

  def airports_csv() do
    Application.app_dir(:airports, "/priv/airports.csv")
  end

  def open_airports() do
    airports_csv()
    |> File.read!()
    |> CSV.parse_string()
    |> Enum.map(&row_to_map/1)
    |> Enum.reject(&(&1.type == "closed"))
  end

  def open_airports_flow() do
    airports_csv()
    |> File.stream!()
    |> Flow.from_enumerable()
    |> Flow.map(&row_to_map_flow/1)
    |> Flow.filter(&(&1.type == "closed"))
    |> Flow.partition(key: {:key, :country})
    |> Flow.group_by(&(&1.country))
    |> Flow.on_trigger(fn map -> { Enum.map(map, fn {k, v} -> {k, Enum.count(v)} end), map } end)
    |> Flow.take_sort(10, fn {_, a}, {_, b} -> a > b end)
    |> Enum.to_list()
    |> List.flatten()
  end

  def open_airports_stream() do
    airports_csv()
    |> File.stream!()
    |> CSV.parse_stream()
    |> Stream.map(&row_to_map_stream/1)
    |> Stream.reject(&(&1.type == "closed"))
    |> Enum.to_list()
  end

  defp row_to_map(row) do
    %{
      id: Enum.at(row, 0),
      country: Enum.at(row, 8),
      name: Enum.at(row, 3),
      type: Enum.at(row, 2)
    }
  end

  defp row_to_map_flow(row) do
    [row] = CSV.parse_string(row, skip_headers: false)

    row_to_map(row)
  end

  defp row_to_map_stream(row) do
    %{
      id: :binary.copy(Enum.at(row, 0)),
      country: :binary.copy(Enum.at(row, 8)),
      name: :binary.copy(Enum.at(row, 3)),
      type: :binary.copy(Enum.at(row, 2))
    }
  end
end
