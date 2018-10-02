defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "expect hash to match name" do
    foo = Identicon.convert_to_hash("foobar")
    bar = Identicon.convert_to_hash("foobar")
    assert foo == bar
  end

  test "expect colors in RGB" do
    name = "foobar"
    foobar =
    name
    |> Identicon.convert_to_hash
    |> Identicon.colors
    assert foobar == ["38", "58", "F6"]
  end
end
