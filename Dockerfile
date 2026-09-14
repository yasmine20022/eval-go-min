FROM golang:1.22 AS builder
WORKDIR /src
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o /out/main .

FROM golang:1.22 AS runtime
WORKDIR /app
COPY --from=builder /out/main /app/main
RUN adduser --disabled-password --gecos '' appuser && chown -R appuser:appuser /app
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s CMD curl -f http://localhost:8000/ || exit 1
USER appuser
CMD ["/app/main"]
