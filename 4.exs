defmodule AdventFour do
  #part 2 solution partially inspired by https://forums.pragprog.com/forums/322/topics/11983

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
    {encrypted_name, sector, checksum}
  end

  # Inspired by https://www.rosettacode.org/wiki/Letter_frequency#Elixir
  def calculate_checksum(encrypted_name) do
    encrypted_name
    |> String.replace("-", "")
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

  def filter_invalid(list) do
    list
    |> Enum.map(&(Tuple.append(&1, calculate_checksum(elem(&1,0)))))
    |> Enum.filter_map(&(elem(&1, 2) == elem(&1, 3)), &({elem(&1, 0), elem(&1, 1)}))
  end

  def solve_puzzle do
    read_file("4.txt")
    |> filter_invalid
    |> Enum.map(fn(x) ->
      encrypted_string = elem(x, 0)
        |> String.replace("-", " ")
        |> String.trim
      {encrypted_string, elem(x, 1)}
    end)
    |> Enum.map(fn(x) -> {shift_phrase(elem(x, 0),elem(x, 1)), elem(x, 1)} end)
    |> Enum.filter(fn(x) -> Regex.match?(~r/north/, elem(x,0)) end)
  end

  def shift_letter(32, _) do
    32
  end

  def shift_letter(letter, shift_amount) do
    rem(letter - 97 + shift_amount, 26) + 97
  end

  def shift_phrase(phrase, shift_amount) do
    phrase
    |> String.to_charlist
    |> Enum.map(&(shift_letter(&1, shift_amount)))
    |> List.to_string
  end


end

# IO.inspect AdventFour.shift_phrase("qzmt zixmtkozy ivhz", 343)

IO.inspect AdventFour.solve_puzzle
