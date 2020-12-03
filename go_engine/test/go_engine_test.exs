defmodule GoEngineTest do
  use ExUnit.Case
  doctest GoEngine

  test "greets the world" do
    assert GoEngine.hello() == :world
  end
end
