defmodule Transaction do
  @derive [Poison.Encoder]
  defstruct [:id, :input, :output]

  def can_withdraw?(from, value) do
    balance_for(from) >= value
  end

  def balance_for(from) do
    for block <- Engine.initialize() do
      for transaction <- block.transactions do
        cond do
          transaction.input.address == from -> 0 + transaction.input.value
          transaction.output.address == from -> 0 - transaction.output.value
          true -> 0
        end
      end
      |> Enum.sum()
    end
    |> Enum.sum()
  end
end
