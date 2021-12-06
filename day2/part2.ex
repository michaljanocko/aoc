{pos, depth, _} =
  File.stream!("input")
  |> Enum.map(&String.trim/1)
  |> Enum.reduce({0, 0, 0}, fn command, {pos, depth, aim} ->
    case command do
      "forward " <> x ->
        {pos + String.to_integer(x), depth + aim * String.to_integer(x), aim}

      "down " <> x ->
        {pos, depth, aim + String.to_integer(x)}

      "up " <> x ->
        {pos, depth, aim - String.to_integer(x)}
    end
  end)

IO.inspect(pos * depth)
