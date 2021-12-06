defmodule Bingo do
  def mark_numbers(n, board) do
    for row <- board do
      for {mark, x} <- row do
        {mark or x == n, x}
      end
    end
  end

  def transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def check_bingo(board) do
    Enum.any?(board, fn row -> Enum.all?(row, &elem(&1, 0)) end) or
      Enum.any?(Bingo.transpose(board), fn col -> Enum.all?(col, &elem(&1, 0)) end)
  end
end

lines =
  File.stream!("input")
  |> Enum.to_list()
  |> Enum.map(&String.trim/1)

random_numbers =
  List.first(lines)
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)

boards =
  lines
  |> Enum.drop(2)
  |> Enum.chunk_every(5, 6)
  |> Enum.map(fn board ->
    board
    |> Enum.map(fn row ->
      row
      |> String.split(" ", trim: true)
      |> Enum.map(&{false, String.to_integer(&1)})
    end)
  end)

try do
  Enum.reduce(random_numbers, boards, fn number, marked_boards ->
    Enum.map(marked_boards, fn board ->
      marked = Bingo.mark_numbers(number, board)

      if Bingo.check_bingo(marked) do
        if length(marked_boards) == 1 do
          throw({number, marked})
        else
          false
        end
      else
        marked
      end
    end)
    |> Enum.filter(& &1)
  end)
catch
  {number, board} ->
    sum =
      board
      |> IO.inspect()
      |> List.flatten()
      |> Enum.filter(&(not elem(&1, 0)))
      |> Enum.map(&elem(&1, 1))
      |> Enum.sum()

    sum * IO.inspect(number)
end
|> IO.inspect()
