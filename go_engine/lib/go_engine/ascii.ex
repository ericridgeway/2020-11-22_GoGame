defmodule GoEngine.Ascii do
  alias GoEngine.Main

  def ascii_from_main(main) do
    Enum.reduce(1..Main.size(main), [], fn (row_num, row_list) ->
      [columns(main, row_num) | row_list]
    end)
    |> Enum.reverse()
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
