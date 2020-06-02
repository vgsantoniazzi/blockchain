defmodule Row do
  @derive [Poison.Encoder]
  defstruct [:value, :public_key]
end
