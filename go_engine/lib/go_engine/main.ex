defmodule GoEngine.Main do
  alias GoEngine.{Pieces, Ascii}

  defstruct [:size, pieces: Pieces.new()]

  def new(size \\ 9) do
    struct(__MODULE__, size: size)
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
  # TODO Maybe move new_from_ascii with-statement error check back up here, and shuffle the
  #   x and y size check above here to be a Pieces function, and this also uses the with syntax
  #
  # I'm also twitchy about this calling Ascii and Ascii calling this. Not sure that double-direction
  #   is ok?


  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end

  def new_from_ascii(ascii_list), do: Ascii.main_from_ascii(ascii_list)
  def ascii(t), do: Ascii.ascii_from_main(t)

  def size(t), do: t.size


  defp pieces(t), do: t.pieces
  defp update_pieces(t, new), do: struct!(t, pieces: new)
end
