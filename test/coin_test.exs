defmodule CoinTest do
  use ExUnit.Case
  doctest Coin

  test "greets the world" do
    assert Coin.hello() == :world
  end
end
