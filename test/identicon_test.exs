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
    |> Identicon.define_colors
    assert foobar.color == {56, 88, 246}
  end

  test "expect row to mirror itself" do
    assert Identicon.mirrow_row([11, 222, 99]) == [11, 222, 99, 222, 11]
  end

  test "expect a grid of tuples" do
    struct =
      Identicon.convert_to_list("foobar")
      |> Identicon.define_colors
      |> Identicon.build_grid
    assert struct.grid ==
      [ {56, 0}, {88, 1}, {246, 2}, {88, 3}, {56, 4},
      {34, 5}, {48, 6}, {172, 7}, {48, 8}, {34, 9},
      {60, 10}, {145, 11}, {95, 12}, {145, 13}, {60, 14},
      {48, 15}, {12, 16}, {102, 17}, {12, 18}, {48, 19},
      {67, 20}, {18, 21}, {198, 22}, {18, 23}, {67, 24}
      ]
  end
end
