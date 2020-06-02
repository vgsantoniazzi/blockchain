defmodule Block do
  @derive [Poison.Encoder]
  defstruct [:index, :timestamp, :transactions, :hash, :previous_hash, :difficulty, :nonce]

  @difficulty 6

  def generate(previous_block, from, to, value) do
    new = %Block{
      index: previous_block.index + 1,
      timestamp: DateTime.utc_now() |> DateTime.to_unix(),
      transactions: [
        %Transaction{
          id:
            :crypto.hash(:sha256, DateTime.utc_now() |> DateTime.to_unix() |> Integer.to_string())
            |> Base.encode16(),
          output: %Row{public_key: from, value: value},
          input: %Row{public_key: to, value: value}
        }
      ],
      previous_hash: previous_block.hash,
      difficulty: @difficulty
    }

    if Transaction.can_withdraw?(from, value) do
      Map.merge(new, generate_hash(new))
    else
      raise ArgumentError, message: "Public key (#{from}): Cannot withdraw value"
    end
  end

  def valid?(block) do
    calculate_hash(block) == block.hash
  end

  def valid?(new_block, previous_block) do
    cond do
      previous_block.index + 1 != new_block.index -> false
      previous_block.hash != new_block.previous_hash -> false
      calculate_hash(new_block) != new_block.hash -> false
      true -> true
    end
  end

  def to_string(block) do
    Enum.join([
      block.index |> Integer.to_string(),
      block.timestamp,
      block.nonce |> Integer.to_string()
    ])
  end

  def calculate_hash(block) do
    :crypto.hash(:sha256, block |> Block.to_string()) |> Base.encode16()
  end

  defp generate_hash(block, nonce \\ 1) do
    hash = calculate_hash(Map.merge(block, %{nonce: nonce}))
    IO.write("\r#{hash}")

    case valid_hash?(hash) do
      true -> %{hash: hash, nonce: nonce}
      false -> generate_hash(block, nonce + 1)
    end
  end

  defp valid_hash?(hash) do
    prefix = String.duplicate("0", @difficulty)
    String.starts_with?(hash, prefix)
  end
end
