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

  describe "Ascii" do
    test "Blank ascii" do
      main =
        Main.new(2)

      assert Main.ascii(main) == [
        ~w[0 0],
        ~w[0 0],
      ]
    end

    test "After adding pieces" do
      main =
        Main.new(3)
        |> Main.add_piece(:black, 1, 1)
        |> Main.add_piece(:white, 3, 2)

      assert Main.ascii(main) == [
        ~w[b 0 0],
        ~w[0 0 w],
        ~w[0 0 0],
      ]
    end

    test "Generate main FROM ascii" do
      target_main =
        Main.new(3)
        |> Main.add_piece(:black, 1, 1)
        |> Main.add_piece(:white, 3, 2)
        |> Main.add_piece(:white, 2, 3)

      generated_main = [
        ~w[b 0 0],
        ~w[0 0 w],
        ~w[0 w 0],
      ]
      |> Main.new_from_ascii()

      assert generated_main == target_main
    end

    test "Error if row length doesnt match num cols" do
      assert {:error, :width_and_height_must_match} = [
        ~w[0 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert {:error, :width_and_height_must_match} = [
        ~w[w],
        ~w[b b],
      ]
      |> Main.new_from_ascii()
    end
  end

  describe "Liberties" do
    test "single stone all liberties" do
      main = [
        ~w[0 0 0],
        ~w[0 b 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.liberties(main, 2, 2) == 4
    end

    test "single stone 1 wall" do
      main = [
        ~w[0 b 0],
        ~w[0 0 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.liberties(main, 2, 1) == 3
    end

    test "single stone cornor" do
      main = [
        ~w[0 0 0],
        ~w[0 0 0],
        ~w[0 0 w],
      ]
      |> Main.new_from_ascii()

      assert Main.liberties(main, 3, 3) == 2
    end

    test "Enemy stones reduce libs" do
      main = [
        ~w[b 0 0],
        ~w[w 0 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.liberties(main, 1, 1) == 1
      assert Main.liberties(main, 1, 2) == 2
    end

    # test "Multiple stones share libs" do
    #   main = [
    #     ~w[0 b 0],
    #     ~w[0 b 0],
    #     ~w[0 0 0],
    #   ]
    #   |> Main.new_from_ascii()

    #   assert Main.liberties(main, 2, 2) == 5
    # end

    # TODO error if check liberties for blank space

    # test "After add_piece, check liberties. Remove if 0" do
    #   TODO
    # end

    # TODO captures counter increases when piece removed
  end

  # TODO more later, history of Pieces's tracked, so no ko (can't repeat piece's states)
end
