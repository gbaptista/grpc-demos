package main

import (
	"google.golang.org/grpc"
	pb "protos/compiled_go/hello"
)

func buildClient(address string) (*grpc.ClientConn, pb.HelloServiceClient) {
	connection, connection_error := grpc.Dial(
		address, grpc.WithInsecure())

	if connection_error != nil {
		panic(connection_error)
	}

	client := pb.NewHelloServiceClient(connection)

	return connection, client
}
