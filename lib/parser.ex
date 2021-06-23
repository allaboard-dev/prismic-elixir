defmodule Prismic.Parser do
  alias Prismic.{AlternateLanguage, Document, Response}

  require Logger

  defmodule ParseError do
    defexception message: "Prismic document(s) contain errors"
  end

  def parse_document(
        %{data: data, first_publication_date: fpd, last_publication_date: lpd} = results_json
      ) do
    {first_publication_date, last_publication_date} = get_publication_dates(fpd, lpd)

    Document
    |> struct(results_json)
    |> Map.update!(:slugs, fn slugs -> Enum.map(slugs, &URI.decode_www_form/1) end)
    |> Map.put(:first_publication_date, first_publication_date)
    |> Map.put(:last_publication_date, last_publication_date)
    |> Map.put(:alternate_languages, parse_alternate_languages(results_json))
    |> Map.put(:data, data)
  end

  def parse_response(%{results: results} = documents) do
    Response
    |> struct(documents)
    |> Map.put(:results, parse_results(results))
  end

  def parse_response(%{error: error} = _documents) do
    raise ParseError, message: "Error : #{error}"
  end

  ## PRIVATE FUNCTIONS

  defp parse_alternate_languages(%{alternate_languages: docs}) do
    Enum.reduce(docs, %{}, fn %{lang: lang} = doc, map ->
      Map.put(map, lang, struct(AlternateLanguage, doc))
    end)
  end

  defp parse_alternate_languages(_), do: nil

  defp parse_results(results), do: Enum.map(results, &parse_document/1)

  defp get_publication_dates(fpb, lpb) do
    first = parse_pub_date(fpb)
    last = parse_pub_date(lpb)

    {first, last}
  end

  defp parse_pub_date(date) when is_binary(date) do
    case DateTime.from_iso8601(date) do
      {:ok, date, 0} -> date
      {:error, _} -> nil
    end
  end

  defp parse_pub_date(nil), do: nil

  def parse_integration_fields(%{type: "IntegrationFields"} = block),
    do: struct(IntegrationFields, block)
end
