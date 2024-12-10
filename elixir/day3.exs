# -----------------------------------------------------------------------------
#
# mix run day3.exs --no-mix-exs
#
# -----------------------------------------------------------------------------

{:ok, file} = File.read("../puzzle_input/day3.txt")

part1 =
  ~r/mul\(\d+,\d+\)/
  |> Regex.scan(file)
  |> Enum.reduce(0, fn ["mul(" <> mul], acc ->
    [left, right, _] = String.split(mul, [",", ")"])

    result = String.to_integer(left) * String.to_integer(right)

    acc + result
  end)

IO.inspect part1, label: "part1"


IO.inspect ~r/don't\(\)/ |> Regex.split(file)


# Regex.escape("don't()")
