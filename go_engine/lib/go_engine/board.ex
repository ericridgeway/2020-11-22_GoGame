defmodule GoEngine.Board do
  defstruct [:size, pieces: %{}]

  def new(size \\ 9) do
    struct(__MODULE__, size: size)
  end

  def add_piece(t, color, x, y) do
    # TODO Pieces.
    t
    |> pieces(Map.put(pieces(t), {x, y}, color))
  end

  def has_piece?(t, color, x, y) do
    color == Map.get(pieces(t), {x, y})
  end

  def size(t), do: t.size

  defp pieces(t), do: t.pieces
  defp pieces(t, new), do: struct!(t, pieces: new)
end
