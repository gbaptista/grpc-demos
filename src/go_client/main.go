package main

import (
	"context"
	"fmt"
	pb "protos/compiled_go/hello"
)

func main() {
	connection, client := buildClient(
		"localhost:50051")

	defer connection.Close()

	response, err := client.SayHello(
		context.Background(),
		&pb.HelloRequest{Name: "gbaptista"})

	if err != nil {
		panic(err)
	}
	fmt.Printf("\nSayHello('gbaptista') -> '%s'\n\n",
		response.Message)
}
