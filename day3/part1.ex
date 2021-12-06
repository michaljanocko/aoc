gamma =
  File.stream!("input")
  |> Enum.map(&String.trim/1)
  |> Enum.map(&String.graphemes/1)
  # Transpose
  |> List.zip()
  |> Enum.map(&Tuple.to_list/1)
  # Count bits
  |> Enum.map(fn col ->
    Enum.reduce(col, %{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
  end)
  |> Enum.map(fn char ->
    if char["0"] < char["1"] do
      "1"
    else
      "0"
    end
  end)
  |> Enum.join()

epsilon =
  gamma
  |> String.graphemes()
  |> Enum.map(fn bit ->
    case bit do
      "0" -> "1"
      "1" -> "0"
    end
  end)
  |> Enum.join()

IO.inspect(
  elem(Integer.parse(gamma, 2), 0) *
    elem(Integer.parse(epsilon, 2), 0)
)
