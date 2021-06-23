ExUnit.start()

defmodule Prismic.Factory do
  @doc """
  It should be possible to generate form, search form, and ref test data from this fixture only.
  """
  def build(:api) do
    %Prismic.API{
      access_token: nil,
      bookmarks: %{
        download: "U0w8OwEAACoAQEvB",
        getinvolved: "UrjI1gEAALOCeO5i",
        homepage: "UqpIfgEAAAE7kmjy"
      },
      forms: [
        arguments: %Prismic.Form{
          action: "https://micro.cdn.prismic.io/api/v1/documents/search",
          enctype: "application/x-www-form-urlencoded",
          fields: %{
            after: %{multiple: false, type: "String"},
            fetch: %{multiple: false, type: "String"},
            fetchLinks: %{multiple: false, type: "String"},
            lang: %{multiple: false, type: "String"},
            orderings: %{multiple: false, type: "String"},
            page: %{default: "1", multiple: false, type: "Integer"},
            pageSize: %{default: "20", multiple: false, type: "Integer"},
            q: %{
              default: "[[:d = any(document.type, [\"argument\"])]]",
              multiple: true,
              type: "String"
            },
            ref: %{multiple: false, type: "String"},
            referer: %{multiple: false, type: "String"}
          },
          method: "GET",
          name: "Arguments",
          rel: "collection"
        },
        contributors: %Prismic.Form{
          action: "https://micro.cdn.prismic.io/api/v1/documents/search",
          enctype: "application/x-www-form-urlencoded",
          fields: %{
            after: %{multiple: false, type: "String"},
            fetch: %{multiple: false, type: "String"},
            fetchLinks: %{multiple: false, type: "String"},
            lang: %{multiple: false, type: "String"},
            orderings: %{multiple: false, type: "String"},
            page: %{default: "1", multiple: false, type: "Integer"},
            pageSize: %{default: "20", multiple: false, type: "Integer"},
            q: %{
              default: "[[:d = any(document.type, [\"contributor\"])]]",
              multiple: true,
              type: "String"
            },
            ref: %{multiple: false, type: "String"},
            referer: %{multiple: false, type: "String"}
          },
          method: "GET",
          name: "Contributors",
          rel: "collection"
        },
        ctas: %Prismic.Form{
          action: "https://micro.cdn.prismic.io/api/v1/documents/search",
          enctype: "application/x-www-form-urlencoded",
          fields: %{
            after: %{multiple: false, type: "String"},
            fetch: %{multiple: false, type: "String"},
            fetchLinks: %{multiple: false, type: "String"},
            lang: %{multiple: false, type: "String"},
            orderings: %{multiple: false, type: "String"},
            page: %{default: "1", multiple: false, type: "Integer"},
            pageSize: %{default: "20", multiple: false, type: "Integer"},
            q: %{
              default: "[[:d = any(document.type, [\"cta\"])]]",
              multiple: true,
              type: "String"
            },
            ref: %{multiple: false, type: "String"},
            referer: %{multiple: false, type: "String"}
          },
          method: "GET",
          name: "Call-to-actions on homepage",
          rel: "collection"
        },
        doc: %Prismic.Form{
          action: "https://micro.cdn.prismic.io/api/v1/documents/search",
          enctype: "application/x-www-form-urlencoded",
          fields: %{
            after: %{multiple: false, type: "String"},
            fetch: %{multiple: false, type: "String"},
            fetchLinks: %{multiple: false, type: "String"},
            lang: %{multiple: false, type: "String"},
            orderings: %{multiple: false, type: "String"},
            page: %{default: "1", multiple: false, type: "Integer"},
            pageSize: %{default: "20", multiple: false, type: "Integer"},
            q: %{
              default: "[[:d = any(document.type, [\"doc\",\"docchapter\"])]]",
              multiple: true,
              type: "String"
            },
            ref: %{multiple: false, type: "String"},
            referer: %{multiple: false, type: "String"}
          },
          method: "GET",
          name: "Documentation",
          rel: "collection"
        },
        everything: %Prismic.Form{
          action: "https://micro.cdn.prismic.io/api/v1/documents/search",
          enctype: "application/x-www-form-urlencoded",
          fields: %{
            after: %{multiple: false, type: "String"},
            fetch: %{multiple: false, type: "String"},
            fetchLinks: %{multiple: false, type: "String"},
            lang: %{multiple: false, type: "String"},
            orderings: %{multiple: false, type: "String"},
            page: %{default: "1", multiple: false, type: "Integer"},
            pageSize: %{default: "20", multiple: false, type: "Integer"},
            q: %{multiple: true, type: "String"},
            ref: %{multiple: false, type: "String"},
            referer: %{multiple: false, type: "String"}
          },
          method: "GET",
          name: nil,
          rel: nil
        },
        references: %Prismic.Form{
          action: "https://micro.cdn.prismic.io/api/v1/documents/search",
          enctype: "application/x-www-form-urlencoded",
          fields: %{
            after: %{multiple: false, type: "String"},
            fetch: %{multiple: false, type: "String"},
            fetchLinks: %{multiple: false, type: "String"},
            lang: %{multiple: false, type: "String"},
            orderings: %{multiple: false, type: "String"},
            page: %{default: "1", multiple: false, type: "Integer"},
            pageSize: %{default: "20", multiple: false, type: "Integer"},
            q: %{
              default: "[[:d = any(document.type, [\"reference\"])]]",
              multiple: true,
              type: "String"
            },
            ref: %{multiple: false, type: "String"},
            referer: %{multiple: false, type: "String"}
          },
          method: "GET",
          name: "References",
          rel: "collection"
        }
      ],
      refs: [
        %Prismic.Ref{
          id: "master",
          isMasterRef: true,
          label: "Master",
          ref: "WH8MzyoAAGoSGJwT",
          scheduledAt: nil
        }
      ],
      repository_url: "https://micro.cdn.prismic.io/api"
    }
  end
end
