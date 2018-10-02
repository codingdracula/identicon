defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  def transformation(name) do
    name
    |> convert_to_hash
    |> colors
  end

  def convert_to_hash(name) do
    hash = :crypto.hash(:md5, name) |> Base.encode16()
    %Identicon.Image{hash: hash}.hash
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