package app

import (
	"blockchain-engine/blockchain"
	"encoding/json"
	"github.com/gorilla/mux"
	"io"
	"log"
	"net/http"
	"os"
)

func Up() error {
	mux := MakeMuxRouter()
	httpPort := os.Getenv("PORT")
	log.Println("HTTP Server Listening on port :", httpPort)
	s := &http.Server{
		Addr:           ":" + httpPort,
		Handler:        mux,
	}

	if err := s.ListenAndServe(); err != nil {
		return err
	}
	return nil
}

func MakeMuxRouter() http.Handler {
	muxRouter := mux.NewRouter()
	muxRouter.HandleFunc("/", HandleGet).Methods("GET")
	return muxRouter
}

func HandleGet(w http.ResponseWriter, r *http.Request) {
	bytes, err := json.MarshalIndent(blockchain.Blockchain, "", "  ")
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	io.WriteString(w, string(bytes))
}
