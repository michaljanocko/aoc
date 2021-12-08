File.stream!("input")
|> Enum.map(&String.trim/1)
|> Enum.map(fn line ->
  [input, digits] =
    String.split(line, " | ", trim: true)
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn x -> Enum.map(x, &(String.graphemes(&1) |> Enum.sort() |> Enum.join())) end)

  # |> Enum.map(&MapSet.new(&1))

  input =
    (input ++ digits)
    |> MapSet.new()
    |> MapSet.to_list()
    |> IO.inspect()

  one = Enum.find(input, &(String.length(&1) == 2))
  seven = Enum.find(input, &(String.length(&1) == 3))
  four = Enum.find(input, &(String.length(&1) == 4))
  eight = Enum.find(input, &(String.length(&1) == 7))

  [nine, zero, six] =
    Enum.sort_by(
      for(n <- input, String.length(n) == 6, do: n),
      &(length(String.graphemes(&1) -- String.graphemes(one)) +
          length(String.graphemes(&1) -- String.graphemes(four)))
    )

  [three, five, two] =
    Enum.sort_by(
      for(n <- input, String.length(n) == 5, do: n) |> IO.inspect(),
      &(length(String.graphemes(&1) -- String.graphemes(one)) +
          length(String.graphemes(&1) -- String.graphemes(four)))
    )

  lookupt = %{
    zero => "0",
    one => "1",
    two => "2",
    three => "3",
    four => "4",
    five => "5",
    six => "6",
    seven => "7",
    eight => "8",
    nine => "9"
  }

  Enum.map_join(digits, &Map.fetch!(lookupt, &1))
  |> String.to_integer()
end)
|> Enum.sum()
|> IO.inspect()
