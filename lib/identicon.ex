defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  def transformation(name) do
    name
    |> convert_to_list
    |> colors
  end

  @doc """
  Takes a string and converts it a binary and then
  converts it to a list of numbers from 0-255
  """
  def convert_to_list(name) do
    list = :crypto.hash(:md5, name)
    |> :binary.bin_to_list
    %Identicon.Image{list: list}
  end

  @doc """
  Takes a struct and pattern matches the whole
  list to the list value of the struct (head).
  Then it pattern matches color (tail) to the
  r,g,b values (first 3 numbers in the list)

  ## Example

        iex> Identicon.transformation("foobar")
        %Identicon.Image{
          color: {56, 88, 246},
          list: [56, 88, 246, 34, 48, 172, 60, 145, 95, 48, 12, 102, 67, 18, 198, 63]
        }

  """
  def colors( %Identicon.Image{list: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end
end