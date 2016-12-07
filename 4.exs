defmodule AdventFour do
  def read_file(file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.drop(-1)
    |> Enum.map(&(parse_line(&1)))
  end

  def parse_line(line) do
    [checksum] = Regex.run(~r/\[\w{5}\]/, line)
    checksum = String.replace(checksum, ~r/[\[\]]/, "")
    [sector] = Regex.run(~r/\d+/, line)
    {sector, ""} = Integer.parse(sector)
    [encrypted_name] = Regex.run(~r/[A-z-]+/, line)
    encrypted_name = String.replace(encrypted_name, "-", "")
    {encrypted_name, sector, checksum}
  end

  # Inspired by https://www.rosettacode.org/wiki/Letter_frequency#Elixir
  def calculate_checksum(encrypted_name) do
    encrypted_name
    |> String.graphemes
    |> Enum.reduce(Map.new, fn c,acc -> Map.update(acc, c, 1, &(&1+1)) end)
    |> Enum.sort(fn(x1, x2) ->
      cond do
        (elem(x1, 1) > elem(x2, 1)) -> true
        (elem(x1, 1) == elem(x2, 1)) -> (elem(x1, 0) < elem(x2, 0))
        true -> false
      end
    end)
    |> Enum.map(&(elem(&1, 0)))
    |> Enum.slice(0..4)
    |> Enum.join("")
  end

  def solve_puzzle do
    read_file("4.txt")
    |> Enum.map(&({calculate_checksum(elem(&1, 0)), elem(&1, 1), elem(&1, 2)}))
    |> Enum.filter_map(&(elem(&1, 0)== elem(&1, 2)), &(elem(&1, 1)))
    |> Enum.reduce(&(&1+&2))
  end
end

# IO.inspect AdventFour.calculate_checksum("notarealroom")

IO.inspect AdventFour.solve_puzzle
