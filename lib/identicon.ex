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
    |> filter
    |> build_pixel_map
    |> draw_image
    |> save_image(name)
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
  Creates a grid with mirrored rows. Flattern
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

  @doc """
  Filter out values, so that the image can be colored.
  This updates the grid with even values.
  """
  def filter(%Identicon.Image{grid: grid} = image) do
    grid =  Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end
    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Creates a pixel map of squares and updates the struct
  pixel map field. This is the basic layout before we can
  render the image.
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical+50}

      {top_left, bottom_right}
    end
    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
  This draws the actual identicon using the egd erlang library.
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({top_left, bottom_right}) ->
      :egd.filledRectangle(image, top_left, bottom_right, fill)
    end
    :egd.render(image)
  end

  @doc """
  Save the file to the hard-disk.
  """
  def save_image(image, name) do
    File.write("images/#{name}.png", image)
  end
end
