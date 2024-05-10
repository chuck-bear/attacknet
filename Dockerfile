FROM golang:1.21 as builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o attacknetd ./cmd/attacknet

# Use a Docker multi-stage build to create a lean production image.
# Start with a smaller image
FROM alpine:latest  

# Copy the binary and any other dependencies from the builder stage
COPY --from=builder /app/attacknetd /usr/local/bin/attacknetd

