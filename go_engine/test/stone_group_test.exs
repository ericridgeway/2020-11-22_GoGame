defmodule GoEngineTest.StoneGroup do
  use ExUnit.Case

  alias GoEngine.{Main}

  test "1 stone group" do
    main = [
      ~w[0 0 0],
      ~w[w 0 0],
      ~w[0 0 0],
    ]
    |> Main.new_from_ascii()

    expected_group = [{1, 2}]
    group = Main.group(main, 1, 2)

    assert expected_group == group
  end

  test "2 stone group" do
    main = [
      ~w[0 b 0],
      ~w[0 b 0],
      ~w[0 0 0],
    ]
    |> Main.new_from_ascii()

    expected_group = [{2, 1}, {2, 2}] |> Enum.sort()
    group = Main.group(main, 2, 1) |> Enum.sort()

    assert expected_group == group
  end

  test "3 stone group" do
    main = [
      ~w[0 b 0],
      ~w[0 b b],
      ~w[0 0 0],
    ]
    |> Main.new_from_ascii()

    expected_group = [{2, 1}, {2, 2}, {3, 2}] |> Enum.sort()
    group = Main.group(main, 2, 1) |> Enum.sort()

    assert expected_group == group
  end

  test "4 stone group" do
    main = [
      ~w[0 w w],
      ~w[0 w w],
      ~w[0 0 0],
    ]
    |> Main.new_from_ascii()

    expected_group = [{2, 1}, {2, 2}, {3, 2}, {3, 1}] |> Enum.sort()
    group = Main.group(main, 2, 1) |> Enum.sort()

    assert expected_group == group
  end

  test "Enemy stones not included" do
    main = [
      ~w[0 w 0],
      ~w[0 w w],
      ~w[0 b 0],
    ]
    |> Main.new_from_ascii()

    expected_group = [{2, 1}, {2, 2}, {3, 2}] |> Enum.sort()
    group = Main.group(main, 2, 1) |> Enum.sort()

    assert expected_group == group
  end
end
