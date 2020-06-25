defmodule Wallets do
  def load do
    case File.read("database/wallets.json") do
      {:ok, body} -> Poison.decode!(body, as: [%Wallet{}])
      {:error, _} -> []
    end
  end

  def append(wallet) do
    if Wallet.valid_address?(wallet.address) do
      wallets = load() ++ [wallet]
      save!(wallets)
    else
      raise ArgumentError, "Invalid wallet"
    end

    wallet
  end

  defp save!(wallets) do
    File.write!("database/wallets.json", wallets |> Poison.encode!(pretty: true))
  end
end
