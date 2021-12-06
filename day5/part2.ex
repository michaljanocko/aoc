File.stream!("input")
|> Enum.map(&String.trim/1)
|> Enum.map(&String.split(&1, [" -> ", ","]))
|> List.flatten()
|> Enum.map(&String.to_integer/1)
|> Enum.chunk_every(2)
|> Enum.chunk_every(2)
|> Enum.reduce(%{}, fn [[x, y], [a, b]], acc ->
  cond do
    x == a ->
      Map.merge(
        Enum.reduce(y..b, acc, &Map.update(&2, "#{x}:#{&1}", 1, fn n -> n + 1 end)),
        Enum.reduce(b..y, acc, &Map.update(&2, "#{x}:#{&1}", 1, fn n -> n + 1 end))
      )

    y == b ->
      Map.merge(
        Enum.reduce(x..a, acc, &Map.update(&2, "#{&1}:#{y}", 1, fn n -> n + 1 end)),
        Enum.reduce(a..x, acc, &Map.update(&2, "#{&1}:#{y}", 1, fn n -> n + 1 end))
      )

    abs(y - b) == abs(x - a) ->
      horizontal =
        if a < x do
          x..a//-1
        else
          x..a
        end

      vertical =
        if b < y do
          y..b//-1
        else
          y..b
        end

      Enum.zip(horizontal, vertical)
      |> Enum.reduce(
        acc,
        &Map.update(&2, "#{elem(&1, 0)}:#{elem(&1, 1)}", 1, fn n -> n + 1 end)
      )
  end
end)
|> Enum.count(&(elem(&1, 1) > 1))
|> IO.inspect()
