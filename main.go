package main

import (
	"blockchain-engine/app"
	"blockchain-engine/blockchain"
	"github.com/joho/godotenv"
	"log"
	"time"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}

	go func() {
		t := time.Now()
		genesisBlock := blockchain.Block{}
		genesisBlock = blockchain.Block{0, t.String(), 0, blockchain.CalculateHash(genesisBlock), "", blockchain.Difficulty, ""}
		blockchain.Blockchain = append(blockchain.Blockchain, genesisBlock)
	}()

	app.Up()
}
