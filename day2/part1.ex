File.stream!("input")
|> Enum.map(&String.trim/1)
|> Enum.reduce({0, 0}, fn command, {pos, depth} ->
  case command do
    "forward " <> x ->
      {pos + String.to_integer(x), depth}

    "down " <> x ->
      {pos, depth + String.to_integer(x)}

    "up " <> x ->
      {pos, depth - String.to_integer(x)}
  end
end)
|> Tuple.to_list()
|> Enum.product()
|> IO.inspect()
