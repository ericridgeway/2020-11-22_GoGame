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

  describe "Board" do
    test "size" do
      main = Main.new(3)

      assert Main.size(main) == 3
    end
  end

  describe "Ascii" do
    test "Blank ascii" do
      main =
        Main.new(2)

      assert Main.ascii(main) == [
        ~w[0 0],
        ~w[0 0],
      ]
    end

    # test "TODO" do
    #   main =
    #     Main.new(3)
    #     |> Main.add_piece(:black, 1, 1)

    #   assert Main.ascii(main) == [
    #     ~w[b 0 0],
    #   ]
    # end
  end
end
