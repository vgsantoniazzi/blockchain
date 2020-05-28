defmodule Coin do
  def initialize do
    case Blockchain.load do
      {:ok, blockchain} -> blockchain
      _ -> Blockchain.load_genesys!
    end
  end

  def generate do
    blockchain = initialize()
    blockchain = Blockchain.add(blockchain, Block.generate(List.last(blockchain), 33))
  end
end
