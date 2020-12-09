defmodule GoEngine.Main do
  alias GoEngine.{Pieces, Ascii, Group}

  defstruct [:size, pieces: Pieces.new()]

  def new(size \\ 9) do
    struct(__MODULE__, size: size)
  end

  def new_from_ascii(ascii_list) do
    with :ok <- Ascii.check_x_and_y_lengths_match(ascii_list) do
      Ascii.main_from_ascii(ascii_list)
    else
      error -> error
    end
  end

  def add_piece(t, color, x, y) do
    with :ok <- Pieces.check_x_and_y_in_range(x, y, size(t)) do
      t
      |> update_pieces(Pieces.add(pieces(t), color, x, y))
    else
      error -> error
    end
  end

  def group(t, x, y, group \\ []) do
    Group.new(pieces(t), x, y)
  end


  def liberties(t, x, y) do
    group(t, x, y)
    |> all_cardinals_for_group()
    |> reject_out_of_bounds(size(t))
    |> reject_duplicates()
    |> only_empty_spaces(pieces(t))
  end

  def num_liberties(t, x, y), do: length(liberties(t, x, y))

  def cardinals(x, y) do
    [
      {x+1, y},
      {x-1, y},
      {x, y+1},
      {x, y-1},
    ]
  end

  defp all_cardinals_for_group(group_list) do
    Enum.reduce(group_list, [], fn ({x, y}, all_cardinals) ->
      Enum.concat(cardinals(x, y), all_cardinals)
    end)
  end

  defp reject_out_of_bounds(cardinals, size) do
    Enum.filter(cardinals, fn {x, y} ->
      x in 1..size and y in 1..size
    end)
  end

  defp reject_duplicates(list), do: Enum.uniq(list)

  defp only_empty_spaces(list, pieces) do
    Enum.filter(list, fn {x, y} ->
      Pieces.color(pieces, x, y) == nil
    end)
  end


  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end

  def ascii(t), do: Ascii.ascii_from_main(t)

  def size(t), do: t.size
  defp pieces(t), do: t.pieces

  defp update_pieces(t, new), do: struct!(t, pieces: new)

#   defp opponent(:black), do: :white
#   defp opponent(:white), do: :black
end
