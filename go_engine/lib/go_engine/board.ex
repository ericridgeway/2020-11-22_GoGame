defmodule GoEngine.Board do
  alias GoEngine.{Pieces}

  defstruct [:size, pieces: Pieces.new()]

  def new(size \\ 9) do
    struct(__MODULE__, size: size)
  end

  def add_piece(t, color, x, y) do
    t
    |> pieces(Pieces.put(pieces(t), color, x, y))
  end

  def has_piece?(t, color, x, y) do
    # TODO is this in Pieces? Should Pieces exist? Idk, look at it and play later. Also decide on the getter setter syntax sort of thing
    color == Map.get(pieces(t), {x, y})
  end

  def size(t), do: t.size

  defp pieces(t), do: t.pieces
  defp pieces(t, new), do: struct!(t, pieces: new)
end
