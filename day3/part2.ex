lines =
  File.stream!("input")
  |> Enum.map(&String.trim/1)

freqs = fn lines ->
  lines
  |> Enum.map(&String.graphemes/1)
  # Transpose
  |> List.zip()
  |> Enum.map(&Tuple.to_list/1)
  # Count bits
  |> Enum.map(fn col ->
    Enum.reduce(col, %{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end)
end

oxygen =
  try do
    for i <- 0..String.length(List.first(lines)), reduce: lines do
      acc ->
        freq = Enum.at(freqs.(acc), i)

        common_bit =
          if freq["0"] > freq["1"] do
            "0"
          else
            "1"
          end

        new_lines =
          Enum.filter(acc, fn line ->
            String.at(line, i) == common_bit
          end)

        if length(new_lines) == 1 do
          throw(List.first(new_lines))
        else
          new_lines
        end
    end
  catch
    value -> IO.inspect(value)
  end

co2 =
  try do
    for i <- 0..String.length(List.first(lines)), reduce: lines do
      acc ->
        freq = Enum.at(freqs.(acc), i)

        common_bit =
          if freq["0"] <= freq["1"] do
            "0"
          else
            "1"
          end

        new_lines =
          Enum.filter(acc, fn line ->
            String.at(line, i) == common_bit
          end)

        if length(new_lines) == 1 do
          throw(List.first(new_lines))
        else
          new_lines
        end
    end
  catch
    value -> IO.inspect(value)
  end

IO.inspect(
  elem(Integer.parse(oxygen, 2), 0) *
    elem(Integer.parse(co2, 2), 0)
)
