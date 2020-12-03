defmodule GoEngineTest.Board do
  use ExUnit.Case

  alias GoEngine.{Board}

  test "New board" do
    board =
      Board.new()
      |> Board.add_piece(:black, 1, 1)

    assert Board.has_piece?(board, :black, 1, 1)
    refute Board.has_piece?(board, :white, 1, 1)
  end
end

# TODO Alternative for has_piece? if only tests need it eventually?
