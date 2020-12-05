defmodule GoEngine.Main do
  alias GoEngine.{Pieces}

  defstruct [pieces: Pieces.new()]

  def new() do
    struct(__MODULE__)
  end

  def add_piece(t, color, x, y) do
    t
    |> update_pieces(Pieces.add(pieces(t), color, x, y))
  end

  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end


  defp pieces(t), do: t.pieces
  defp update_pieces(t, new), do: struct!(t, pieces: new)
end
