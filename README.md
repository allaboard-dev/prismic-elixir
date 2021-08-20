# Prismic

This is an Elixir-based SDK for Prismic.io. Based on the [TheRealReal/prismic-elixir](https://travis-ci.org/TheRealReal/prismic-elixir), but
forked to add support for the Prismic v2 API.

**Note:** This is currently not intended to be used outside All Aboard.

Mostly based on https://github.com/prismicio/ruby-kit and https://github.com/prismicio/javascript-kit

- The primary authors of this library are:
  1. Coburn Berry ([coburncoburn](https://github.com/coburncoburn))
  - API
  - Cache
  - Predicates
  2. David Wu ([sudostack](https://github.com/sudostack))
  - Fragments
  - Parser

## Installation

```elixir
def deps do
  [
      {:prismic, git: "https://github.com/allaboard-dev/prismic-elixir", branch: "main"}
  ]
end
```

set repo url in your project's config

```elixir
  config :prismic,
    repo_url: "https://micro.cdn.prismic.io/api"
```

## Usage

TODO

## Configuring HTTP Client

The default HTTP Client is Poison. It is possible to use any http client that implements the [ Prismic.HTTPClient behaviour ](https://github.com/therealreal/prismic-elixir/blob/master/lib/http_client.ex#L1).

Then, set the HTTPClient Module in config or within

```
Application.put_env(:prismic, :http_client_module, MyApp.HTTPClient)
```

## Configuring Cache

The default Cache is an [ Agent ](https://github.com/therealreal/prismic-elixir/blob/master/lib/cache.ex#L23). It is possible to use any cache that implements the [ Prismic.Cache behaviour ](https://github.com/therealreal/prismic-elixir/blob/master/lib/cache.ex#L1).

Then, set the Cache Module in config or within

```
Application.put_env(:prismic, :cache_module, MyApp.Cache)
```

Only the first leg of the request ( api entrypoint ) is cached. Actual document queries are not cached. It is probably better to just cache calls to the library itself rather than worrying about caching in the library.
