defmodule Block do
  @derive [Poison.Encoder]
  defstruct [:index, :timestamp, :value, :hash, :previous_hash, :difficulty, :nonce]

  @difficulty 5

  def generate(previous_block, value) do
    IO.inspect(previous_block)
    new = %Block{
      index: previous_block.index + 1,
      timestamp: DateTime.utc_now |> DateTime.to_unix,
      value: value,
      previous_hash: previous_block.hash,
      difficulty: @difficulty
    }

    Map.merge(new, generate_hash(new))
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
    Enum.join([block.index |> Integer.to_string, block.timestamp, block.nonce |> Integer.to_string])
  end

  def calculate_hash(block) do
    :crypto.hash(:sha256, block |> Block.to_string) |> Base.encode16()
  end

  defp generate_hash(block, nonce \\ 1) do
    hash = calculate_hash(Map.merge(block, %{nonce: nonce}))

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
