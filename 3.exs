defmodule AdventThree do
  def read_file(file) do
    File.read!(file)
    |> String.split("\n", trim: true)
    # Rewrite following line -- it's nearly inscrutable
    |> Enum.map(&(String.split(&1) |> Enum.map(fn(x) -> Integer.parse(x) |> elem(0) end)))
  end

  def solve_puzzle do
    read_file("3.txt")
    |> List.zip
    |> Enum.map(&(Tuple.to_list(&1)))
    |> List.flatten
    |> Enum.chunk(3)
    |> Enum.map(&(is_triangle?(Enum.at(&1, 0), Enum.at(&1, 1), Enum.at(&1, 2))))
    |> Enum.reduce(&(&1+&2))
  end

  def is_triangle?(a, b, c) do
    if a + b > c && a + c > b && b + c > a do
      1
    else
      0
    end
  end
end

IO.inspect AdventThree.solve_puzzle
