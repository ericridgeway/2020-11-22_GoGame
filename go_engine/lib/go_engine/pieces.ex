defmodule GoEngine.Pieces do

  defdelegate new(), to: Map

  def put(t, color, x, y), do: Map.put(t, {x, y}, color)
end
