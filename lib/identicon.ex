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

  def colors(hash) do
     [r, g, b | _tail] =
    hash
    |> String.codepoints
    |> Enum.chunk_every(2)
    |> Enum.map(&Enum.join/1)
    [r, g, b]
  end
end