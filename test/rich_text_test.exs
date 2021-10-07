defmodule Prismic.RichTextTest do
  use ExUnit.Case, async: true

  alias Prismic.RichText

  describe "as_text/1" do
    test "returns the text parts of the data" do
      actual = RichText.as_text(prismic_data)

      assert actual == "A > B <example>\n  TEST\n</example> This is bold and italic and both."
    end

    def prismic_data do
      mock = [
        %{type: "paragraph", text: "A > B", spans: []},
        %{type: "preformatted", text: "<example>\n  TEST\n</example>", spans: []},
        %{
          type: "paragraph",
          text: "This is bold and italic and both.",
          spans: [
            %{
              start: 8,
              end: 12,
              type: "strong"
            },
            %{
              start: 17,
              end: 23,
              type: "em"
            },
            %{
              start: 28,
              end: 32,
              type: "strong"
            },
            %{
              start: 28,
              end: 32,
              type: "em"
            }
          ]
        }
      ]
    end
  end
end
