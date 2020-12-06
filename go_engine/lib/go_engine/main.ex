defmodule GoEngine.Main do
  alias GoEngine.{Pieces}

  defstruct [:size, pieces: Pieces.new()]

  def new(size \\ 9) do
    struct(__MODULE__, size: size)
  end

  def add_piece(t, color, x, y) do
    t
    |> update_pieces(Pieces.add(pieces(t), color, x, y))
  end

  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end

  def ascii(t) do
    Enum.reduce(1..size(t), [], fn (_row_num, row_list) ->
      [columns(t) | row_list]
    end)
    |> Enum.reverse()
  end

  def size(t), do: t.size


  defp pieces(t), do: t.pieces
  defp update_pieces(t, new), do: struct!(t, pieces: new)

  defp columns(t) do
    Enum.reduce(1..size(t), [], fn (_col_num, col_list) ->
      ["0" | col_list]
    end)
    |> Enum.reverse()
  end
end
