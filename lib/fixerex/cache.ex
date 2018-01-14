defmodule FixerEx.Cache do
  ##== Preamble ===========================================================
  use GenServer

  
  ##== API ================================================================
  def rates(base \\ "EUR", symbols \\ []) do
    GenServer.call(__MODULE__, {:rates, base, symbols}, 30000)
  end

  
  ##== GenServer callbacks ================================================
  def start_link() do
    args = nil
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def stop() do
    GenServer.stop(__MODULE__)
  end
  
  def init(_args) do
    rates = _rates()

    Process.send_after(self(), :update, 300000)

    {:ok, rates}
  end

  def handle_info(:update, _rates) do
    rates = _rates()

    Process.send_after(self(), :update, 300000)

    {:noreply, rates}
  end

  def handle_call({:rates, base, []}, _from, rates) do
    rs = Map.get(rates, base)
    {:reply, rs, rates}
  end
  def handle_call({:rates, base, symbols}, _from, rates) when is_list(symbols) do
    rs = Map.get(rates, base)
    rs = symbols |> Enum.map(fn(s) -> {s, Map.get(rs, s)} end)
    rs = Map.new(rs)
    {:reply, rs, rates}
  end
  def handle_call({:rates, base, symbol}, _from, rates)  do
    rs = Map.get(rates, base)
    rs = [symbol] |> Enum.map(fn(s) -> {s, Map.get(rs, s)} end)
    rs = Map.new(rs)
    {:reply, rs, rates}
  end

  
  ##== Local functions ====================================================
  defp currencies() do
    [
      "AUD", "BGN", "BRL", "EUR",
      "CAD", "CHF", "CNY", "CZK",
      "DKK", "GBP", "HKD", "HRK",
      "HUF", "IDR", "ILS", "INR",
      "JPY", "KRW", "MXN", "MYR",
      "NOK", "NZD", "PHP", "PLN",
      "RON", "RUB", "SEK", "SGD",
      "THB", "TRY", "USD", "ZAR"
    ]
  end
  
  defp _rates() do
    rates = currencies() |> Enum.map(fn(c) -> {c, _rates(c)} end)
    Map.new(rates)
  end

  defp _rates(base) do
    FixerEx.rates([], base, "latest", false)
  end

end
