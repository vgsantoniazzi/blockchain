GO=go
MAIN=main.go
EXECUTABLE=bin/blockchain

.DEFAULT_GOAL := build

app.server:
	$(GO) run $(MAIN)

build:
	$(GO) build -o $(EXECUTABLE) $(MAIN)

format:
	$(GO)fmt -s -w .

clean:
	rm -f $(EXECUTABLE)

