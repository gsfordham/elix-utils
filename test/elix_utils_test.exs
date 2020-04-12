defmodule ElixUtilsTest do
  use ExUnit.Case
  doctest ElixUtils

  test "greets the world" do
    assert ElixUtils.hello() == :world
  end
end
