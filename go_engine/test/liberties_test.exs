defmodule GoEngineTest.Liberties do
  use ExUnit.Case

  alias GoEngine.{Main}

  describe "Liberties" do
    test "single stone all liberties" do
      main = [
        ~w[0 0 0],
        ~w[0 b 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.num_liberties(main, 2, 2) == 4
    end

    test "single stone 1 wall" do
      main = [
        ~w[0 b 0],
        ~w[0 0 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.num_liberties(main, 2, 1) == 3
    end

    test "single stone cornor" do
      main = [
        ~w[0 0 0],
        ~w[0 0 0],
        ~w[0 0 w],
      ]
      |> Main.new_from_ascii()

      assert Main.num_liberties(main, 3, 3) == 2
    end

    test "Enemy stones reduce libs" do
      main = [
        ~w[b 0 0],
        ~w[w 0 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.num_liberties(main, 1, 1) == 1
      assert Main.num_liberties(main, 1, 2) == 2
    end
  end

  describe "Multi-stone liberties" do
    test "Multiple stones share libs" do
      main = [
        ~w[0 b 0],
        ~w[0 b 0],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.num_liberties(main, 2, 2) == 5
    end

    test "Dont double-count lib even if touched twice" do
      main = [
        ~w[0 b 0],
        ~w[0 b b],
        ~w[0 0 0],
      ]
      |> Main.new_from_ascii()

      assert Main.num_liberties(main, 2, 2) == 5
    end

    test "Enemy stones still reduce libs" do
      main = [
        ~w[0 b 0],
        ~w[0 b b],
        ~w[0 w 0],
      ]
      |> Main.new_from_ascii()

      assert Main.num_liberties(main, 2, 2) == 4
    end
  end
end
