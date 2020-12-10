defmodule GoEngine.Pieces do
  defdelegate new(), to: Map

  def add(t, color, x, y) do
    Map.put(t, {x, y}, color)
  end

  def delete(t, x, y) do
    Map.delete(t, {x, y})
  end

  def color(t, x, y) do
    Map.get(t, {x, y})
  end

  def list_color(t, target_color) do
    Enum.filter(t, fn {_coords, color} ->
      color == target_color
    end)
    |> Enum.map(& elem(&1, 0))
  end

  def has_piece?(t, color, x, y) do
    color == color(t, x, y)
  end

  def check_x_and_y_in_range(x, y, range) do
    if x in 1..range and y in 1..range do
      :ok
    else
      {:error, :add_piece_outside_range}
    end
  end

  def check_has_piece(t, x, y) do
    if color(t, x, y) != nil do
      :ok
    else
      {:error, :cant_check_libs_for_blank_space}
    end
  end
end
