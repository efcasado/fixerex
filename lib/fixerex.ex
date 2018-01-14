###========================================================================
### File: fixerex.ex
###
###
### Author(s):
###   - Enrique Fernandez <efcasado@gmail.com>
###
### Copyright (c) 2018, Enrique Fernandez
###========================================================================
defmodule FixerEx do
  ##== Preamble ===========================================================
  @moduledoc """
  Foreign exchange rates and currency conversion.
  """

  use Application
  require Logger

  @api_endpoint "https://api.fixer.io"


  ##== Application callbacks ==============================================
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [worker(FixerEx.Cache, [])]

    opts = [strategy: :one_for_one, name: FixerEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  
  ##== API ================================================================
  def rates(symbols \\ [], base \\ "EUR", date \\ "latest", use_cache \\ true)
  def rates(symbols, base, "latest", true) do
    FixerEx.Cache.rates(base, symbols)
  end
  def rates(symbols, base, date, _use_cache) when is_list(symbols) do
    _rates(base, Enum.join(symbols, ","), date)
  end
  def rates(symbol , base, date, _use_cache) do
    _rates(base, symbol, date)
  end

  defp _rates(base, "", date) do
    url = url([date], %{base: base})
    %{"rates" => rates} = get(url)
    rates
  end
  defp _rates(base, symbols, date) do
    url = url([date], %{base: base, symbols: symbols})
    %{"rates" => rates} = get(url)
    rates
  end

  
  ##== Auxiliary functions ================================================
  defp url(path, []) do
    Enum.join([@api_endpoint| path], "/")
  end
  defp url(path, params) do
    params = URI.encode_query(params)
    Enum.join([@api_endpoint| path], "/") <> "?" <> params
  end
  
  defp get(url) do
    resp = HTTPoison.get!(url)
    {:ok, resp} = parse_response(resp)
    resp
  end

  defp parse_response(resp = %HTTPoison.Response{status_code: 200}) do
    resp = Poison.decode! resp.body
    {:ok, resp}
  end
  defp parse_response(resp) do
    Logger.error("Got error from Fixer | #{inspect resp}")
    {:error, resp}
  end
  
end
