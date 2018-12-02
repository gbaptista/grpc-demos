package main

import (
	"google.golang.org/grpc"
	"net"
)

func listenServer(server *grpc.Server, port string) {
	listen, listen_error := net.Listen(
		"tcp", ":"+port)

	if listen_error != nil {
		panic(listen_error)
	}

	serve_error := server.Serve(listen)

	if serve_error != nil {
		panic(serve_error)
	}
}
