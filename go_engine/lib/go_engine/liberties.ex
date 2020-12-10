defmodule GoEngine.Liberties do
  alias GoEngine.{Main, Pieces, Group}

  def get_list(group, pieces, board_size) do
    group
    |> all_cardinals_for_group()
    |> reject_out_of_bounds(board_size)
    |> reject_duplicates()
    |> only_empty_spaces(pieces)
  end

  def capture(main, color) do
    Main.pieces(main)
    |> Pieces.list_color(color)
    |> Enum.reduce(Main.pieces(main), fn ({x, y}, new_pieces) ->
      if Main.liberties?(main, x, y) do
        new_pieces
      else
        Pieces.delete(new_pieces, x, y)
      end
    end)
  end


  defp all_cardinals_for_group(group) do
    Enum.reduce(group, [], fn ({x, y}, all_cardinals) ->
      Enum.concat(Group.cardinals(x, y), all_cardinals)
    end)
  end

  defp reject_out_of_bounds(group, size) do
    Enum.filter(group, fn {x, y} ->
      x in 1..size and y in 1..size
    end)
  end

  defp reject_duplicates(group), do: Enum.uniq(group)

  defp only_empty_spaces(group, pieces) do
    Enum.filter(group, fn {x, y} ->
      Pieces.color(pieces, x, y) == nil
    end)
  end
end
