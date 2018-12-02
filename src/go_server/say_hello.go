package main

import (
	"context"
	pb "protos/compiled_go/hello"
)

func (server *grpc_server) SayHello(ctx context.Context, args *pb.HelloRequest) (*pb.HelloReply, error) {
	return &pb.HelloReply{
		Message: "hello " + args.Name + "!"}, nil
}
