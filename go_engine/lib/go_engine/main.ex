defmodule GoEngine.Main do
  alias GoEngine.{Pieces}

  defstruct [:size, pieces: Pieces.new()]

  def new(size \\ 9) do
    struct(__MODULE__, size: size)
  end

  # TODO with statement error check (and test first uneven rows cols #s)
  def new_from_ascii(ascii_list) do
    size = length(ascii_list)

    ascii_list
    |> Enum.with_index(1)
    |> Enum.reduce(new(size), fn ({row, row_num}, t) ->

      row
      |> Enum.with_index(1)
      |> Enum.reduce(t, fn ({col, col_num}, t) ->
        case col do
          "b" -> add_piece(t, :black, col_num, row_num)
          "w" -> add_piece(t, :white, col_num, row_num)
          _ -> t
        end
      end)

    end)
  end

  def add_piece(t, color, x, y) do
    t
    |> update_pieces(Pieces.add(pieces(t), color, x, y))
  end

  def has_piece?(t, color, x, y) do
    Pieces.has_piece?(pieces(t), color, x, y)
  end

  def ascii(t) do
    Enum.reduce(1..size(t), [], fn (row_num, row_list) ->
      [columns(t, row_num) | row_list]
    end)
    |> Enum.reverse()
  end

  def size(t), do: t.size


  defp pieces(t), do: t.pieces
  defp update_pieces(t, new), do: struct!(t, pieces: new)

  defp columns(t, row_num) do
    Enum.reduce(1..size(t), [], fn (col_num, col_list) ->
      letter =
        cond do
          has_piece?(t, :black, col_num, row_num) -> "b"
          has_piece?(t, :white, col_num, row_num) -> "w"
          true -> "0"
        end

        [letter | col_list]
    end)
    |> Enum.reverse()
  end
end
