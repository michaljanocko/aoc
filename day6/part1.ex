defmodule Fish do
  def simulate_generation(pop, counter) do
    if counter == 0 do
      pop
      |> Map.to_list()
      |> Enum.map(&elem(&1, 1))
      |> Enum.sum()
    else
      %{
        0 => pop[1] || 0,
        1 => pop[2] || 0,
        2 => pop[3] || 0,
        3 => pop[4] || 0,
        4 => pop[5] || 0,
        5 => pop[6] || 0,
        6 => (pop[7] || 0) + (pop[0] || 0),
        7 => pop[8] || 0,
        8 => pop[0] || 0
      }
      |> simulate_generation(counter - 1)
    end
  end
end

File.stream!("input")
|> Enum.to_list()
|> List.first()
|> String.trim()
|> String.split(",")
|> Enum.map(&String.to_integer/1)
|> Enum.frequencies()
|> Fish.simulate_generation(80)
|> IO.inspect()
