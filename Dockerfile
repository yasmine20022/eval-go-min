FROM golang:1.22-alpine as builder
WORKDIR /src
COPY . /src
RUN go build -o /app ./

FROM golang:1.22-alpine as runtime
COPY --from=builder /app /app
RUN addgroup --system app && adduser --system --ingroup app app
EXPOSE 8000
HEALTHCHECK CMD curl --fail http://localhost:8000/health || exit 1
USER app
CMD ["/app"]
