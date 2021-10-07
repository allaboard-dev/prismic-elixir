defmodule Prismic.RichText do
  def as_text(rich_text) do
    rich_text
    |> Enum.map(& &1["text"])
    |> Enum.join(" ")
  end
end
