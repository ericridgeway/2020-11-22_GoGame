defmodule GoEngineTest.Ascii do
  use ExUnit.Case

  alias GoEngine.{Main}

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
