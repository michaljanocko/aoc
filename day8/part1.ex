File.stream!("input")
|> Enum.map(&String.trim/1)
|> Enum.map(fn line ->
  line
  |> String.split(" | ", trim: true)
  |> Enum.at(1)
  |> String.split(" ")
  |> Enum.count(fn number ->
    case String.length(number) do
      2 -> true
      3 -> true
      4 -> true
      7 -> true
      _ -> false
    end
  end)
end)
|> Enum.sum()
|> IO.inspect()
