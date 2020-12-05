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
  end
end
