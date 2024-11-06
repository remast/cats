# 1. App Builder
FROM golang AS builder
WORKDIR /app
ADD . /app
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -o build/cats .

# 2. App Container
FROM gcr.io/distroless/static
COPY --from=builder /app/build/cats /usr/bin/
EXPOSE 8080
ENTRYPOINT ["/usr/bin/cats"]
