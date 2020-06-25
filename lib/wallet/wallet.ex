defmodule Wallet do
  defstruct [:address, :public_key, :private_key]
  @version "00"

  def generate do
    {public_key, private_key} = :crypto.generate_key(:ecdh, :secp256k1)

    %Wallet{
      address: address(public_key_hash(public_key)),
      public_key: public_key |> Base.encode16(case: :lower),
      private_key: private_key |> Base.encode16(case: :lower)
    }
  end

  def valid_address?(address) do
    public_key_hash = Base58.decode(address)
    checksum(public_key_hash |> String.slice(2..-10)) == public_key_hash |> String.slice(-9..-1)
  end

  def public_key_hash(public_key) do
    sha256 = :crypto.hash(:sha256, public_key)
    :crypto.hash(:ripemd160, sha256) |> Base.encode16(case: :lower)
  end

  def checksum(public_key_hash) do
    sha256 = :crypto.hash(:sha256, public_key_hash)
    sha256 = :crypto.hash(:sha256, sha256) |> Base.encode16(case: :lower)
    sha256 |> String.slice(0..8)
  end

  def address(public_key_hash) do
    Base58.encode(@version <> public_key_hash <> checksum(public_key_hash))
  end
end
