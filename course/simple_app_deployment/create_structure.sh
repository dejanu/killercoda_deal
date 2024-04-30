
mkdir demo


cat > Dockerfile <<- "EOF"
# Use an official Golang runtime as a base image
FROM golang:latest AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy the source code from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o main .

# Start a new stage from scratch
FROM debian:buster-slim

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/main .

# Expose port 3333 to the outside world
EXPOSE 3333

# Command to run the executable
CMD ["./main"]
EOF