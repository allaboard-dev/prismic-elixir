defmodule Prismic do
  @moduledoc """
  TODO Document options
  """

  require Logger
  alias Prismic.{API, Cache, Document, Predicate, SearchForm}

  defp repo_url, do: Application.get_env(:prismic, :repo_url)

  def api(url \\ repo_url()) do
    # TODO: include access token in cache key after supporting tokens
    # + (access_token ? ('#' + access_token) : '')
    api_cache_key = url

    entrypoint_response =
      Cache.get_or_store(api_cache_key, fn ->
        case Prismic.HTTPClient.get(url) do
          {:ok, %{status_code: 200}} = response ->
            {:commit, response}

          response ->
            {:ignore, response}
        end
      end)

    case entrypoint_response do
      {:ok, %{body: body, status_code: status_code}} when status_code != 200 ->
        {:error, body}

      {:ok, %{body: body}} ->
        API.new(body, url)

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Retrieve all documents (paginated)
  param opts map query options (page, pageSize, ref, etc.)
  """
  def all(opts \\ %{}) do
    with {:ok, search_form} <- everything_search_form(opts) do
      submit_and_extract_results(search_form)
    else
      {:error, _error} = error -> error
    end
  end

  @doc """
  Retrieve one document by its id

  See moduledoc for options.

  Returns `nil` or one document.
  """
  def get_by_id(id, opts) do
    with {:ok, search_form} <- everything_search_form(opts) do
      case search_form
           |> SearchForm.set_query_predicates([Predicate.at("document.id", id)])
           |> submit_and_extract_results() do
        [doc] -> doc
        [] -> nil
      end
    end
  end

  @doc """
  Retrieve document by its uid

  See moduledocs for options

  Returns one document or `nil`
  """
  def get_by_uid(type, uid, opts) do
    with {:ok, %SearchForm{} = search_form} <- everything_search_form(opts) do
      case search_form
           |> SearchForm.set_query_predicates([Predicate.at("my." <> type <> ".uid", uid)])
           |> submit_and_extract_results() do
        [] -> nil
        [doc] -> doc
      end
    end
  end

  @doc """
  Retrieve multiple documents by their ids

  See moduledocs for options.

  Returns a list of documents
  """
  def get_by_ids(ids, opts) do
    with {:ok, search_form} <- everything_search_form(opts) do
      search_form
      |> SearchForm.set_query_predicates([Predicate.where_in("document.id", ids)])
      |> submit_and_extract_results()
    end
  end

  @doc """
  Retrive multiple documents by tags

  See moduledocs for options.

  Returns a list of documents with the specified tags and type.
  """
  def get_by_tags(type, tags, opts) do
    with {:ok, search_form} <- everything_search_form(opts) do
      search_form
      |> SearchForm.set_query_predicates([
        Predicate.at("document.tags", tags),
        Predicate.at("document.type", type)
      ])
      |> submit_and_extract_results()
    end
  end

  @doc """
  Retrieve documents of a certain type
  """
  def get_by_type(type, opts) do
    with {:ok, search_form} <- everything_search_form(opts) do
      search_form
      |> SearchForm.set_query_predicates([Predicate.at("document.type", type)])
      |> submit_and_extract_results()
    end
  end

  @doc """
  Retrieve all documents matching a list of predicates
  """
  def get_by_predicates(predicates, opts) when is_list(predicates) and predicates != [] do
    with {:ok, search_form} <- everything_search_form(opts) do
      search_form
      |> SearchForm.set_query_predicates(predicates)
      |> submit_and_extract_results()
    end
  end

  @doc """
  Return the URL to display a given preview
  @param token [String] as received from Prismic server to identify the content to preview
  @return [String] the URL to redirect the user to
  """
  def preview_documents(token) do
    token = token |> URI.decode()

    with {:ok, %{status_code: 200, body: body}} <- Prismic.HTTPClient.get(token),
         {:ok, json} = Poison.decode(body),
         {:ok, search_form} = everything_search_form() do
      search_form
      |> SearchForm.set_query_predicates([Predicate.at("document.id", json["mainDocument"])])
      |> SearchForm.set_data_field(:ref, token)
      |> submit_and_extract_results()
    else
      _ -> {:ok, []}
    end
  end

  @spec everything_search_form(map()) :: {:ok, SearchForm.t()} | {:error, any()}
  def everything_search_form(opts \\ %{}) do
    repo_url = opts[:repo_url] || repo_url()

    with {:ok, api} <- api(repo_url),
         %SearchForm{} = search_form <- SearchForm.from_api(api, :everything, opts) do
      {:ok, search_form}
    else
      {:error, _error} = error ->
        error

      nil ->
        {:error, "No `:everything` form available for #{repo_url}"}
    end
  end

  defp submit_and_extract_results(%SearchForm{} = search_form) do
    case SearchForm.submit(search_form) do
      {:ok, response} ->
        {:ok, Map.get(response, :results, [])}

      {:error, _response} = response ->
        response
    end
  end
end
