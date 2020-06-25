defmodule Row do
  @derive [Poison.Encoder]
  defstruct [:value, :address]
end
