defmodule Engine do
  def initialize do
    case Blockchain.load() do
      {:ok, blockchain} -> blockchain
      _ -> Blockchain.load_genesys!()
    end
  end
end
