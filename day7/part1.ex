pos =
  File.stream!("input")
  |> Enum.map(&String.trim/1)
  |> List.first()
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

{min, max} = Enum.min_max(pos)

min..max
|> Enum.map(fn goal ->
  pos
  |> Enum.map(&abs(goal - &1))
  |> Enum.sum()
end)
|> Enum.with_index()
|> Enum.min_by(&elem(&1, 0))
|> IO.inspect()
