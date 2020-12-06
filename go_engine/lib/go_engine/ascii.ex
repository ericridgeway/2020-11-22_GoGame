defmodule GoEngine.Ascii do
  alias GoEngine.Main

  def ascii_from_main(main) do
    Enum.reduce(1..Main.size(main), [], fn (row_num, row_list) ->
      [columns(main, row_num) | row_list]
    end)
    |> Enum.reverse()
  end

  def main_from_ascii(ascii_list) do
    size = length(ascii_list)

    ascii_list
    |> Enum.with_index(1)
    |> Enum.reduce(Main.new(size), fn ({row, row_num}, t) ->

      row
      |> Enum.with_index(1)
      |> Enum.reduce(t, fn ({col, col_num}, t) ->
        case col do
          "b" -> Main.add_piece(t, :black, col_num, row_num)
          "w" -> Main.add_piece(t, :white, col_num, row_num)
          _ -> t
        end
      end)

    end)
  end

  def check_x_and_y_lengths_match(list) do
    target_size = length(list)

    all_match = Enum.all?(list, fn row ->
      length(row) == target_size
    end)

    if all_match, do: :ok, else: {:error, :width_and_height_must_match}
  end


  defp columns(main, row_num) do
    Enum.reduce(1..Main.size(main), [], fn (col_num, col_list) ->
      letter =
        cond do
          Main.has_piece?(main, :black, col_num, row_num) -> "b"
          Main.has_piece?(main, :white, col_num, row_num) -> "w"
          true -> "0"
        end

        [letter | col_list]
    end)
    |> Enum.reverse()
  end
end
