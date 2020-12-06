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
    size = size(t)

    if x in 1..size and y in 1..size do
      t
      |> update_pieces(Pieces.add(pieces(t), color, x, y))
    else
      {:error, :add_piece_outside_range}
    end
  end

  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end

  def ascii(t), do: Ascii.ascii_from_main(t)

  def size(t), do: t.size


  defp pieces(t), do: t.pieces
  defp update_pieces(t, new), do: struct!(t, pieces: new)
end
