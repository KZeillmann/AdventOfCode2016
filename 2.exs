defmodule AdventTwo do
  def read_file(file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.map(&(parse_instruction_list(&1)))
  end

  def parse_instruction_list(instruction_list) do
    String.split(instruction_list, "")
    |> Enum.drop(-1)
    |> Enum.map(&(parse_direction(&1)))
  end

  def parse_direction(direction) do
    case direction do
      "U" -> :up
      "D" -> :down
      "L" -> :left
      "R" -> :right
    end
  end

  def solve_puzzle do
    read_file("2.txt")
    |> Enum.reduce("5", &(solve_number(&2, &1)))
  end

  def solve_number(start_num, instruction_list) do
    Enum.reduce(instruction_list, start_num, &(next_number(&2, &1)))
    |> IO.inspect
  end

  def next_number(start_num, instruction) do
    case instruction do
      :up -> up(start_num)
      :down -> down(start_num)
      :left -> left(start_num)
      :right -> right(start_num)
    end
  end

  def up(number) do
    case number do
      "1" -> "1"
      "2" -> "2"
      "3" -> "1"
      "4" -> "4"
      "5" -> "5"
      "6" -> "2"
      "7" -> "3"
      "8" -> "4"
      "9" -> "9"
      "A" -> "6"
      "B" -> "7"
      "C" -> "8"
      "D" -> "B"
    end
  end

  def down(number) do
    case number do
      "1" -> "3"
      "2" -> "6"
      "3" -> "7"
      "4" -> "8"
      "5" -> "5"
      "6" -> "A"
      "7" -> "B"
      "8" -> "C"
      "9" -> "9"
      "A" -> "A"
      "B" -> "D"
      "C" -> "C"
      "D" -> "D"
    end
  end

  def left(number) do
    case number do
      "1" -> "1"
      "2" -> "2"
      "3" -> "2"
      "4" -> "3"
      "5" -> "5"
      "6" -> "5"
      "7" -> "6"
      "8" -> "7"
      "9" -> "8"
      "A" -> "A"
      "B" -> "A"
      "C" -> "B"
      "D" -> "D"
    end
  end

  def right(number) do
    case number do
      "1" -> "1"
      "2" -> "3"
      "3" -> "4"
      "4" -> "4"
      "5" -> "6"
      "6" -> "7"
      "7" -> "8"
      "8" -> "9"
      "9" -> "9"
      "A" -> "B"
      "B" -> "C"
      "C" -> "C"
      "D" -> "D"
    end
  end

end

IO.inspect AdventTwo.solve_puzzle
