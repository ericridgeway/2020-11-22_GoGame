defmodule GoEngine.Ascii do
  alias GoEngine.Main

  def ascii_from_main(main) do
    Enum.reduce(1..Main.size(main), [], fn (row_num, row_list) ->
      [draw_ascii_columns(main, row_num) | row_list]
    end)
    |> Enum.reverse()
  end

  def main_from_ascii(ascii_list) do
    size = length(ascii_list)

    ascii_list
    |> Enum.with_index(1)
    |> Enum.reduce(Main.new(size), fn ({row, row_num}, main) ->
      add_pieces_from_ascii(main, row, row_num)
    end)
  end

  def check_x_and_y_lengths_match(ascii_list) do
    target_size = length(ascii_list)

    all_match = Enum.all?(ascii_list, fn row ->
      length(row) == target_size
    end)

    if all_match, do: :ok, else: {:error, :width_and_height_must_match}
  end


  defp draw_ascii_columns(main, row_num) do
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

  defp add_pieces_from_ascii(main, row, row_num) do
    row
    |> Enum.with_index(1)
    |> Enum.reduce(main, fn ({col, col_num}, main) ->
      case col do
        "b" -> Main.add_piece(main, :black, col_num, row_num)
        "w" -> Main.add_piece(main, :white, col_num, row_num)
        _ -> main
      end
    end)
  end
end

# NOTE @William I'm a little twitchy about Main calling Ascii and Ascii calling Main. Not sure that double-direction is ok?
#   For example, Main ONLY calls Pieces. Pieces doesn't know Main exists
#   Ascii is almost just a 2nd half of the Main file. It's just a nice sub-group of the main file that I thought looked more readable/organized in another module. But it needs to do a lot of Main stuff inside itself, Main.new, main.add_piece. It could even hold the with-statement error check that new_from_ascii has wrapped around it's call "down" to Ascii...
