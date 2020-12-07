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

  def liberties(t, x, y, checked \\ [], count \\ 0) do
    color = Pieces.color(pieces(t), x, y)
    opponent = opponent(color)

    liberties_list =
      cardinals(x, y)
      |> reject_out_of_bounds(size(t))
      |> reject_opponent_stones(t, opponent)
      |> reject_checked(checked)
      |> Enum.reduce(count, fn {neighbor_x, neighbor_y}, count ->
        case Pieces.color(pieces(t), neighbor_x, neighbor_y) do
          ^color -> liberties(t, neighbor_x, neighbor_y, [{x, y} | checked], count)
          nil -> count + 1
          _ -> {:error, :bad_piece_type} # shouldnt be able to get here...
        end
      end)
      # |> Kernel.+(count)

    # checked = [{x, y} | checked]

    # length(liberties_list) + count
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

  defp reject_checked(neighbors, checked) do
    Enum.reject(neighbors, fn {x, y} ->
      # TODO & syntax works here I think
      {x, y} in checked
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
