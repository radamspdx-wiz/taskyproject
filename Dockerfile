# Building the binary of the App
FROM golang:bullseye AS build

WORKDIR /go/src/tasky
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /go/src/tasky/tasky

FROM alpine:3.17.0 as release

WORKDIR /app
COPY --from=build  /go/src/tasky/tasky .
COPY --from=build  /go/src/tasky/assets ./assets
RUN echo "tech Exercise Step complete" > /app/assets/wizexercise.txt
EXPOSE 8080
ENTRYPOINT ["/app/tasky"]

