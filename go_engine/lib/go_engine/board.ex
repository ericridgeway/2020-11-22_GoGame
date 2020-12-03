defmodule GoEngine.Board do

  def new() do
    %{}
  end

  def add_piece(t, color, x, y) do
    Map.put(t, {x, y}, color)
  end

  def has_piece?(t, color, x, y) do
    color == Map.get(t, {x, y})
  end
end
