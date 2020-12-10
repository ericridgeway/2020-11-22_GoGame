defmodule GoEngine.Main do
  alias GoEngine.{Pieces, Ascii, Group, Liberties}

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
      |> capture(opponent(color))
      # TODO actually this should check that 1 before here and then TRYING to capture self
      #   is the same. Otherwise it was a suicide move which is disallowed. Can test this later
      # |> capture(t, color)
    else
      error -> error
    end
  end

  def group(t, x, y), do: Group.new(pieces(t), x, y)

  def liberties(t, x, y) do
    with :ok <- Pieces.check_has_piece(pieces(t), x, y) do
      group(t, x, y)
      |> Liberties.get_list(pieces(t), size(t))
    else
      error -> error
    end
  end

  def num_liberties(t, x, y), do: length(liberties(t, x, y))
  def liberties?(t, x, y), do: num_liberties(t, x, y) > 0

  def capture(t, color) do
    update_pieces(t, Liberties.capture(t, color))
  end


  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end

  def ascii(t), do: Ascii.ascii_from_main(t)

  def size(t), do: t.size
  def pieces(t), do: t.pieces

  defp update_pieces(t, new), do: struct!(t, pieces: new)

  defp opponent(:black), do: :white
  defp opponent(:white), do: :black
end
