defmodule AdventOne do
  def read_file(file) do
    File.read!(file)
    |> String.split(",")
    |> Enum.map(&(String.trim(&1)))
    |> Enum.map(&(parse_instruction(&1)))
  end

  def parse_instruction(instruction) do
    {direction_str, steps_str} = String.split_at(instruction, 1)
    {num_steps, _ } = Integer.parse(steps_str)
    direction =
      case direction_str do
        "L" -> :left
        "R" -> :right
      end
    {direction, num_steps}
  end

  def turn_left(initial_direction) do
    case initial_direction do
      :north -> :west
      :west -> :south
      :south -> :east
      :east ->  :north
    end
  end

  def turn_right(initial_direction) do
    case initial_direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  def new_compass_direction(compass_direction, instruction_direction) do
    case instruction_direction do
      :left -> turn_left(compass_direction)
      :right -> turn_right(compass_direction)
    end
  end

  def travel({x, y}, compass_direction, steps) do
    case compass_direction do
      :north -> {x, y+steps}
      :south -> {x, y-steps}
      :east -> {x+steps, y}
      :west -> {x-steps, y}
    end
  end

  def obey({x,y,compass_direction, history}, {direction, steps}) do
    new_direction = new_compass_direction(compass_direction, direction)
    {new_x, new_y} = travel({x,y}, new_direction, steps)
    points = points_between(x,y, new_x, new_y)
    points = Enum.drop(points, -1)
    Enum.each(points, fn(point) ->
      if(Enum.member?(history, point)) do
        IO.inspect "We've been here before! #{elem(point, 0)}, #{elem(point, 1)}"
      end
    end)
    history = history ++ points
    {new_x, new_y, new_direction, history}
  end

  def final_destination(filename) do
    read_file(filename)
    |> Enum.reduce({0,0,:north, []}, fn(x, acc) -> obey(acc, x) end)
  end

  def points_between(p1x, p1y, p2x, p2y) do
    if p1x == p2x do
      Enum.reduce(p1y..p2y, [], &( &2 ++ [{p1x, &1}]))
    else
      Enum.reduce(p1x..p2x, [], &(&2 ++ [{&1, p1y}]))
    end
  end

end

# IO.inspect AdventOne.read_file("1.txt")


#IO.inspect AdventOne.points_between(0, -2, -5, -2)
IO.inspect AdventOne.final_destination("1.txt")
