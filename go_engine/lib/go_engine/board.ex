defmodule GoEngine.Board do

  def new(size \\ 9) do
    %{}
  end

  def add_piece(t, color, x, y) do
    Map.put(t, {x, y}, color)
  end

  def has_piece?(t, color, x, y) do
    color == Map.get(t, {x, y})
  end

  def size(t), do: 9
end
