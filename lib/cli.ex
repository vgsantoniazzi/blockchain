defmodule CLI do
  use ExCLI.DSL, mix_task: :hustle

  name("hustle")
  description("Hustle Blockchain CLI")

  long_description(~s"""
    Command line interface
  """)

  option(:verbose, count: true, aliases: [:v])

  command :list do
    description("Lists the blockchain")

    run _context do
      for block <- Coin.initialize() do
        IO.inspect(block)
      end
    end
  end

  command :add do
    description("Add new block to blockchain")
    option(:value, help: "Value to add", required: true, type: :integer)
    option(:from, help: "Account to withdraw", required: true)
    option(:to, help: "Account to receive", required: true)

    run context do
      if context.verbose > 0 do
        IO.puts("Mining..")
      end

      blockchain = Coin.initialize()
      block = Block.generate(List.last(blockchain), context[:from], context[:to], context[:value])
      Blockchain.add(blockchain, block)
      IO.puts("")
      IO.inspect(block)
    end
  end

  command :check do
    description("Check if block is valid")
    option(:block, help: "Blockchain hash", required: true)

    run context do
      blockchain = Coin.initialize()
      block = Enum.find(blockchain, fn x -> x.hash == context[:block] end)

      if block do
        IO.inspect(block)
        IO.puts("Valid: #{Block.valid?(block)}")
      else
        IO.puts("Block not found")
      end
    end
  end

  command :balance do
    description("Get balance")

    option(:public_key, help: "Public key hash", required: true)

    run context do
      balance = Transaction.balance_for(context[:public_key])
      IO.puts("Balance for #{context[:public_key]}: #{balance}")
    end
  end
end
