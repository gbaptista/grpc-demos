package main

import (
  "context"
  "log"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
	pb "protos/compiled_go/hello"
)

type grpc_server struct{}

func buildServer() *grpc.Server {
	server := grpc.NewServer(
    grpc.UnaryInterceptor(logHandler))

	pb.RegisterHelloServiceServer(server, &grpc_server{})
	reflection.Register(server)

	return server
}

func logHandler(ctx context.Context, request interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
  response, response_error := handler(
    ctx, request)

  if response_error == nil {
    log.Printf("%s", info.FullMethod)
  } else {
    log.Printf(
      "%s ERROR: %s",
      info.FullMethod, response_error)
  }

  return response, response_error
}
