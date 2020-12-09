defmodule GoEngineTest.Main do
  use ExUnit.Case

  alias GoEngine.{Main}

  describe "Pieces" do
    test "add_piece & has_piece?" do
      main =
        Main.new()
        |> Main.add_piece(:black, 1, 1)

      assert Main.has_piece?(main, :black, 1, 1)
      refute Main.has_piece?(main, :white, 1, 1)
    end

    test "Error if add_piece outside size" do
      assert {:error, :add_piece_outside_range} =
        Main.new(4)
        |> Main.add_piece(:black, 5, 1)

      assert {:error, :add_piece_outside_range} =
        Main.new(4)
        |> Main.add_piece(:white, 1, 0)
    end
  end

  describe "Board" do
    test "size" do
      main = Main.new(3)

      assert Main.size(main) == 3
    end
  end

  # TODO error if check liberties for blank space

  # test "After add_piece, check liberties. Remove if 0" do
  #   TODO
  # end

  # TODO captures counter increases when piece removed

  # TODO later, history of Pieces's tracked, so no ko (can't repeat piece's states)
end
