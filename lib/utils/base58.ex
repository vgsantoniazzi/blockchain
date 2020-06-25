defmodule Base58 do
  @alnum ~c(123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz)

  def encode(""), do: ""

  def encode(binary) when is_binary(binary) do
    decimal = :binary.decode_unsigned(binary)

    if decimal == 0 do
      leading_zeros(binary, "")
    else
      codes = get_codes(decimal, [])
      leading_zeros(binary, "") <> codes_to_string(codes)
    end
  end

  def encode(int) when is_integer(int) do
    int
    |> Integer.to_string()
    |> encode()
  end

  def encode(val) when is_float(val) do
    val
    |> Float.to_string()
    |> encode()
  end

  def encode(atom) when is_atom(atom) do
    atom
    |> Atom.to_string()
    |> encode()
  end

  defp get_codes(int, codes) do
    rest = div(int, 58)
    code = rem(int, 58)

    if rest == 0 do
      [code | codes]
    else
      get_codes(rest, [code | codes])
    end
  end

  defp codes_to_string(codes) do
    codes
    |> Enum.map(&<<Enum.at(@alnum, &1)>>)
    |> Enum.join()
  end

  defp leading_zeros(<<0, rest::binary>>, acc) do
    leading_zeros(rest, acc <> "1")
  end

  defp leading_zeros(_bin, acc) do
    acc
  end

  def decode(""), do: ""
  def decode("\0"), do: ""
  def decode(encoded), do: recurse(encoded |> to_charlist, 0)
  defp recurse([], acc), do: acc |> :binary.encode_unsigned()

  defp recurse([head | tail], acc) do
    recurse(tail, acc * 58 + Enum.find_index(@alnum, &(&1 == head)))
  end

  def decode_to_int(encoded) do
    decode(encoded)
    |> String.to_integer()
  end
end
