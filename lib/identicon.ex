defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  transform name into an identicon
  """
  def transformation(name) do
    name
    |> convert_to_list
    |> define_colors
    |> build_grid
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
  """
  def define_colors( %Identicon.Image{list: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  creates a grid with mirrored rows. flattern
  converts a list of lists to a list. Then an
  index is added to the flattened list. This
  creates a list with 2 element tuples. We
  then save that into the grid
  """
  def build_grid(%Identicon.Image{list: list} = image) do
    grid =
      list
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirrow_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Takes a single row and returns an updated list
  with values duplicated in the row to create a
  mirror image of the original row.
  """
  def mirrow_row(row) do
    [first, second | _tail] = row
    # appends second, first elements to row
    row  ++ [second, first]
  end
end