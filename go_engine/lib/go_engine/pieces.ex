defmodule GoEngine.Pieces do
  defdelegate new(), to: Map

  def add(t, color, x, y) do
    Map.put(t, {x, y}, color)
  end

  def color(t, x, y) do
    Map.get(t, {x, y})
  end

  def has_piece?(t, color, x, y) do
    color == Map.get(t, {x, y})
  end

  def check_x_and_y_in_range(x, y, range) do
    if x in 1..range and y in 1..range do
      :ok
    else
      {:error, :add_piece_outside_range}
    end
  end
end
