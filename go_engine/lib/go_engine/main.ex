defmodule GoEngine.Main do
  alias GoEngine.{Pieces, Ascii}

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
    group = add_current_to_group(group, x, y)
    color = Pieces.color(pieces(t), x, y)

    cardinals(x, y)
    |> Enum.reduce(group, fn ({neighbor_x, neighbor_y}, new_group) ->
      neighbor_color = Pieces.color(pieces(t), neighbor_x, neighbor_y)

      if not({neighbor_x, neighbor_y} in new_group) and (color == neighbor_color) do
        group(t, neighbor_x, neighbor_y, new_group)
      else
        new_group
      end
    end)
  end

  defp add_current_to_group(group, x, y) do
    [{x, y} | group]
  end

  def liberties(t, x, y) do
    # color = Pieces.color(pieces(t), x, y)
    # opponent = opponent(color)

    # liberties_list =
    #   cardinals(x, y)
    #   |> reject_out_of_bounds(size(t))
    #   |> reject_opponent_stones(t, opponent)

    # length(liberties_list)

    {neighbors, checked} = neighbors(t, x, y)
    length(neighbors)
  end

  defp neighbors(t, x, y, checked \\ []) do
    if {x, y} in checked do
      {[], checked}
    else
      color = Pieces.color(pieces(t), x, y)
      opponent = opponent(color)

    # {liberties, checked} =
      cardinals(x, y)
      |> reject_out_of_bounds(size(t))
      |> reject_opponent_stones(t, opponent)
      |> Enum.reduce({[], checked}, fn ({neighbor_x, neighbor_y}, {liberties, checked}) ->
        case Pieces.color(pieces(t), neighbor_x, neighbor_y) do
          nil -> {[{neighbor_x, neighbor_y} | liberties], checked}
          ^color ->
            {new_liberties, new_checked} = neighbors(t, neighbor_x, neighbor_y, [{x, y} | checked])
              {[new_liberties | liberties], new_checked}
              _ -> {:error, :bad_piece_type} # shouldnt be able to get here...
                end
        end)
        # killDuplicatesInLiberties
    end
  end

  defp cardinals(x, y) do
    [
      {x+1, y},
      {x-1, y},
      {x, y+1},
      {x, y-1},
    ]
  end

  defp reject_out_of_bounds(cardinals, size) do
    Enum.filter(cardinals, fn {x, y} ->
      x in 1..size and y in 1..size
    end)
  end

  defp reject_opponent_stones(neighbors, t, opponent) do
    Enum.reject(neighbors, fn {x, y} ->
      Pieces.color(pieces(t), x, y) == opponent
    end)
  end


  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end

  def ascii(t), do: Ascii.ascii_from_main(t)

  def size(t), do: t.size
  defp pieces(t), do: t.pieces

  defp update_pieces(t, new), do: struct!(t, pieces: new)

  defp opponent(:black), do: :white
  defp opponent(:white), do: :black
end
