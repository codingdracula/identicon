defmodule IdenticonTest do
  use ExUnit.Case
  doctest Identicon

  test "expect a list to always be the same" do
    foo = Identicon.convert_to_list("foobar")
    bar = Identicon.convert_to_list("foobar")
    assert foo == bar
  end

  test "expect colors in RGB" do
    name = "foobar"
    foobar =
    name
    |> Identicon.convert_to_list
    |> Identicon.colors
    assert foobar.color == {56, 88, 246}
  end
end
