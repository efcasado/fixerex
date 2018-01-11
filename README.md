# FixerEx

A [Fixer](http://fixer.io/) client written in [Elixir](http://elixir-lang.github.io/).

Fixer is a Foreign exchange (FOREX) rates and currency conversion API.


## Usage

```elixir
FixerEx.rates("USD")
# %{"base" => "EUR", "date" => "2018-01-11", "rates" => %{"USD" => 1.2017}}

FixerEx.rates(["USD", "SEK"])
# %{"base" => "EUR", "date" => "2018-01-11", "rates" => %{"SEK" => 9.8203, "USD" => 1.2017}}

FixerEx.rates(["USD", "SEK"], "GBP")
# %{"base" => "GBP", "date" => "2018-01-11", "rates" => %{"SEK" => 11.025, "USD" => 1.3491}}

FixerEx.rates(["USD", "SEK"], "GBP", "2001-12-28")
# %{"base" => "GBP", "date" => "2001-12-28", "rates" => %{"SEK" => 15.285, "USD" => 1.4483}}
```


## Author(s)

- Enrique Fernandez `<efcasado@gmail.com>`


## License

> The MIT License (MIT)
>
> Copyright (c) 2018, Enrique Fernandez
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.
