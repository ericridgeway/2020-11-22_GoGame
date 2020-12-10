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

    # TODO extract Pieces test? It'll be making Main AND Pieces calls...
    alias GoEngine.{Pieces}
    test "List color" do
      main =
        Main.new()
        |> Main.add_piece(:black, 1, 1)
        |> Main.add_piece(:black, 2, 1)
        |> Main.add_piece(:white, 2, 2)

      expected_list = [{1, 1}, {2, 1}] |> Enum.sort()
      list = Pieces.list_color(Main.pieces(main), :black) |> Enum.sort()

      assert expected_list == list
    end
  end

  describe "Board" do
    test "size" do
      main = Main.new(3)

      assert Main.size(main) == 3
    end
  end

  describe "Captures- Check entire board 1 color at a time (opponent loses stones first)" do
    test "No captures if all cur color pieces have liberties" do
      main = [
        ~w[0 w b],
        ~w[0 0 w],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      capture_white = Main.capture(main, :white)

      assert capture_white == main
    end

    test "Capture things that have 0 liberties" do
      main = [
        ~w[0 w b],
        ~w[0 0 w],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()
      |> Main.capture(:black)

      expected_main = [
        ~w[0 w 0],
        ~w[0 0 w],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert main == expected_main
    end
  end

  # test "After add_piece, check liberties. Remove if 0" do
  #   TODO
  # end

  # TODO captures counter increases when piece removed

  # TODO later, history of Pieces's tracked, so no ko (can't repeat piece's states)
end
