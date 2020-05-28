## Welcome to Hustle Coin

This project is an open-source blockchain engine based on Elixir. Exchange knowledge by virtual money.

## Getting Started

Clone the project:

```
git clone git@github.com:vgsantoniazzi/hustle-coin.git
```

## Usage

##### Install dependencies

```
$ mix deps.get
```

##### Initialize engine

```
$ iex -S mix
```

##### Initialize Blockchain

```
iex(1)> blockchain = Coin.initialize
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
