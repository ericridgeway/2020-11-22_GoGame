defmodule GoEngine.Group do
  alias GoEngine.{Pieces}

  def new(pieces, x, y) do
    add_current_and_check_neighbors(pieces, x, y)
  end

  def cardinals(x, y) do
    [
      {x+1, y},
      {x-1, y},
      {x, y+1},
      {x, y-1},
    ]
  end


  defp add_current_and_check_neighbors(pieces, x, y, group \\ []) do
    group = add_current_to_group(group, x, y)
    color = Pieces.color(pieces, x, y)

    cardinals(x, y)
    |> Enum.reduce(group, fn ({neighbor_x, neighbor_y}, new_group) ->
      neighbor_color = Pieces.color(pieces, neighbor_x, neighbor_y)

      if color == neighbor_color
          and not_already_in_group(new_group, neighbor_x, neighbor_y) do
        add_current_and_check_neighbors(pieces, neighbor_x, neighbor_y, new_group)
      else
        new_group
      end
    end)
  end

  defp add_current_to_group(group, x, y) do
    [{x, y} | group]
  end

  defp not_already_in_group(group, x, y) do
    not({x, y} in group)
  end
end
