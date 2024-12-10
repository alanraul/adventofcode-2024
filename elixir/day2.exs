# -----------------------------------------------------------------------------
#
# mix run day2.exs --no-mix-exs
#
# -----------------------------------------------------------------------------

defmodule Day2 do
  @file_path "../puzzle_input/day2.txt"

  @doc """

  """
  @spec run :: integer()
  def run do
    Enum.reduce(_file_stream(), {0, 0}, fn line, {part1, part2} ->
      levels = _levels(line)

      safe_or_unsafe = _checking(levels)

      if safe_or_unsafe == :safe do
        # IO.inspect levels ++ [safe_or_unsafe]
        {part1 + 1, part2}
      else
        {part1, part2}
      end
    end)
  end

  @spec _file_stream :: struct()
  defp _file_stream, do: File.stream!(@file_path)

  @spec _levels(String.t()) :: list()
  defp _levels(line) do
    line
    |> String.trim
    |> String.split(" ")
  end

  @spec _checking(list()) :: atom()
  defp _checking([head | tail]) do
    [before_level, next_level, distance] = _distance(head, List.first(tail))

    cond do
      before_level < next_level and distance in [1, 2, 3] ->
        _increase(tail)
      before_level > next_level and distance in [1, 2, 3] ->
        _decrease(tail)
      true ->
        :unsafe
    end
  end

  @spec _increase(list()) :: atom()
  defp _increase([head | tail]) do
    [before_level, next_level, distance] = _distance(head, List.first(tail))

    cond do
      before_level < next_level and length(tail) == 1 and distance in [1, 2, 3] ->
        :safe
      before_level < next_level and distance in [1, 2, 3] ->
        _increase(tail)
      true ->
        :unsafe
    end
  end

  @spec _decrease(list()) :: atom()
  defp _decrease([head | tail]) do
    [before_level, next_level, distance] = _distance(head, List.first(tail))

    cond do
      before_level > next_level and length(tail) == 1 and distance in [1, 2, 3] ->
        :safe
      before_level > next_level and distance in [1, 2, 3] ->
        _decrease(tail)
      true ->
        :unsafe
    end
  end

  @spec _distance(String.t(), String.t()) :: list
  defp _distance(head, tail) do
    before_level = String.to_integer(head)
    next_level = String.to_integer(tail)

    distance = Kernel.abs(before_level - next_level)

    [before_level, next_level, distance]
  end
end

IO.inspect Day2.run(), label: "Part 1"
