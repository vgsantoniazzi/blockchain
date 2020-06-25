## Welcome to Blockchain

This project is an open-source blockchain engine based on Elixir. Use this engine to build a digital coin or smart contracts.

## Getting Started

Clone the project:

```
git clone git@github.com:vgsantoniazzi/blockchain.git
```

## Usage

##### Install dependencies

```
$ mix deps.get
```

## CLI

```
$ mix blockchain

Commands
   balance         Get balance
   check_address   Check if address is valid
   check_block     Check if block is valid
   add_wallet      Add new wallet to local database
   add_block       Add new block to blockchain
   wallets         List addresses
   blocks          Lists the blockchain

```

## CLI Examples

```
$ mix blockchain balance --address 3czs3SwkAnisqC3cUBi5XgytkA2NscG33AJ7YKhaz9scd2XY9pUqQktrXcZQ5aFa6VPCFT
$ mix blockchain check_address --address 3czzKxPGECGxsfwG1zVUBvUxxe7c7AbPoburpmFdJxQdDyeT8Ng8KSCLmk2ewmQnKVPVAy
$ mix blockchain check_block --block 0000C12AC4308926C493DBC3C93A4EBB724D6B2B480358E56E72ED394149F8CD
$ mix blockchain add_wallet
$ mix blockchain add_block --from "3czs3SwkAnisqC3cUBi5XgytkA2NscG33AJ7YKhaz9scd2XY9pUqQktrXcZQ5aFa6VPCFT" --to "3czzX9L9P8Sg1MhuZER1hekBde4bmyNwkER5FARYmVLb99Kn5efEXE65zJ5GDQ3zqZn2SX" --value 455
$ mix blockchain wallets
$ mix blockchain blocks
```

##### Initialize engine

```
$ iex -S mix
```

##### Initialize Blockchain

```
iex(1)> blockchain = Engine.initialize
```

##### Add Block to Blockchain

```
iex(1)> blockchain = Blockchain.add(blockchain, Block.generate(List.last(blockchain), 99))
```

##### Format code

```
mix format
```

## Contributing

I :heart: Open source!

Before sending a pull request: Please, format the source code

```
make format
```

[Follow github guides for forking a project](https://guides.github.com/activities/forking/)

[Follow github guides for contributing open source](https://guides.github.com/activities/contributing-to-open-source/#contributing)

[Squash pull request into a single commit](http://eli.thegreenplace.net/2014/02/19/squashing-github-pull-requests-into-a-single-commit/)

## License

blockchain-engine is released under the [MIT license](http://opensource.org/licenses/MIT).
