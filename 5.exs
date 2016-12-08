defmodule AdventFive do

  def solve_puzzle do
    "ojvtpuvg"
    |> try_hash(0, "")
  end

  def md5(input) do
    :crypto.hash(:md5, input) |> Base.encode16
  end

  def starts_with_five_zeroes?(input) do
    String.slice(input, 0..4) == "00000"
  end

  def try_hash(input, num, progress) do
    if String.length(progress) == 8 do
      progress
    else
      hash = md5(input <> Integer.to_string(num))
      if starts_with_five_zeroes?(hash) do
        IO.puts progress
        try_hash(input, num+1, progress <> String.at(hash, 5))
      else
        try_hash(input, num+1, progress)
      end
    end
  end

end

IO.inspect AdventFive.solve_puzzle
