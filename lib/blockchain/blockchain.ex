defmodule Blockchain do
  def load do
    case File.read("database/blockchain.json") do
      {:ok, body} -> Poison.decode(body, as: blockchain_structure())
      {:error, reason} -> {:error, reason}
    end
  end

  def load_genesys! do
    File.read!("database/genesys.json") |> Poison.decode!(as: blockchain_structure())
  end

  def add(blockchain, block) do
    if Block.valid?(block, List.last(blockchain)) do
      blockchain = blockchain ++ [block]
      save!(blockchain)
    end

    blockchain
  end

  defp blockchain_structure() do
    [
      %Block{
        transactions: [
          %Transaction{
            input: %Row{},
            output: %Row{}
          }
        ]
      }
    ]
  end

  defp save!(blockchain) do
    File.write!("database/blockchain.json", blockchain |> Poison.encode!(pretty: true))
  end
end
