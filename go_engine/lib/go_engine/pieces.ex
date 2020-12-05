defmodule GoEngine.Pieces do
  defdelegate new(), to: Map

  def add(t, color, x, y) do
    Map.put(t, {x, y}, color)
  end

  def has_piece?(t, color, x, y) do
    color == Map.get(t, {x, y})
  end
end
