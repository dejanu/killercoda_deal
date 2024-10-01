
mkdir demo && cd demo

cat > Dockerfile <<- "EOF"
# Use an official Golang runtime as a base image
FROM golang:1.22.5 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the source code from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64  go build -o main .

# Start a new stage from scratch buster:slim (OLD)
FROM debian:bullseye-slim

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/main .

# Expose port 3333 to the outside world
EXPOSE 3333

# Command to run the executable
CMD ["./main"]
EOF


cat > main.go <<- "EOF"
package main

import (
	"fmt"
	"io"
	"net/http"
)

func getRoot(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("got /hello request\n")
	io.WriteString(w, "Hello world!\n")
}

func main() {
	http.HandleFunc("/hello", getRoot)
	http.ListenAndServe(":3333", nil)
}
EOF
