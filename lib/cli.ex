defmodule CLI do
  use ExCLI.DSL, mix_task: :blockchain

  name("blockchain")
  description("Blockchain CLI")

  long_description(~s"""
    Command line interface
  """)

  option(:verbose, count: true, aliases: [:v])

  command :blocks do
    description("Lists the blockchain")

    run _context do
      for block <- Engine.initialize() do
        IO.inspect(block)
      end
    end
  end

  command :wallets do
    description("List addresses")

    run _context do
      for wallet <- Wallets.load() do
        IO.inspect(wallet)
      end
    end
  end

  command :add_block do
    description("Add new block to blockchain")
    option(:value, help: "Value to add", required: true, type: :integer)
    option(:from, help: "Account to withdraw", required: true)
    option(:to, help: "Account to receive", required: true)

    run context do
      if context.verbose > 0 do
        IO.puts("Mining..")
      end

      blockchain = Engine.initialize()
      block = Block.generate(List.last(blockchain), context[:from], context[:to], context[:value])
      Blockchain.add(blockchain, block)
      IO.puts("")
      IO.inspect(block)
    end
  end

  command :add_wallet do
    description("Add new wallet to local database")

    run _context do
      wallet = Wallets.append(Wallet.generate())
      IO.inspect(wallet)
    end
  end

  command :check_block do
    description("Check if block is valid")
    option(:block, help: "Blockchain hash", required: true)

    run context do
      blockchain = Engine.initialize()
      block = Enum.find(blockchain, fn x -> x.hash == context[:block] end)

      if block do
        IO.inspect(block)
        IO.puts("Valid: #{Block.valid?(block)}")
      else
        IO.puts("Block not found")
      end
    end
  end

  command :check_address do
    description("Check if address is valid")
    option(:address, help: "Address hash", required: true)

    run context do
      result = Wallet.valid_address?(context[:address])
      IO.puts("Valid: #{result}")
    end
  end

  command :balance do
    description("Get balance")

    option(:address, help: "Address hash", required: true)

    run context do
      balance = Transaction.balance_for(context[:address])
      IO.puts("Balance for #{context[:address]}: #{balance}")
    end
  end
end
