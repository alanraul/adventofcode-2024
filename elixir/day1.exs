# -----------------------------------------------------------------------------
#
# mix run day1.exs --no-mix-exs
#
# -----------------------------------------------------------------------------

[left_list, right_list] =
  "../puzzle_input/day1.txt"
  |> File.stream!()
  |> Enum.reduce([[], []], fn line, [left_list, right_list] ->
    [left, right, _] = String.split(line, ["   ", "\n"])

    left = String.to_integer(left)
    right = String.to_integer(right)

    [left_list ++ [left], right_list ++ [right]]
  end)

sort_left_list = Enum.sort(left_list)
sort_right_list = Enum.sort(right_list)

distance_list =
  sort_left_list
  |> Enum.zip(sort_right_list)
  |> Enum.map(fn {left, right} -> Kernel.abs(left - right) end)

IO.inspect Enum.sum(distance_list), label: "Part 1"

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

counting_right_list =
  Enum.reduce(right_list, %{}, fn item, acc ->
    case Map.get(acc, item) do
      nil ->
        Map.put(acc, item, 1)
      count ->
        Map.put(acc, item, count + 1)
    end
  end)

left_list
|> Enum.reduce(0, fn item, acc ->
  case Map.get(counting_right_list, item) do
    nil ->
      acc
    count ->
      acc + (item * count)
  end
end)
|> IO.inspect(label: "Part 2")
