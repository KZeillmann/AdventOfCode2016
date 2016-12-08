defmodule AdventSix do
  def read_file(file) do
    File.read!(file)
    |> String.split("\n")
  end

  def solve_puzzle do
    file_content = read_file("6.txt")
    0..7
    |> Enum.map(&(all_letters_in_index(&1, file_content)))
    |> Enum.map(&(most_common_letter(&1)))
    |> Enum.join("")
  end

  def all_letters_in_index(index, word_list) do
    word_list
    |> Enum.map(&(String.at(&1, index)))
  end

  def most_common_letter(letters) do
    letters
    |> Enum.reduce(Map.new, fn c,acc -> Map.update(acc, c, 1, &(&1+1)) end)
    |> Enum.max_by(&(elem(&1, 1)))
    |> elem(0)
  end
end

IO.inspect AdventSix.solve_puzzle
