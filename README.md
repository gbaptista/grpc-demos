# gRPC Demos

- [Proto](#proto)
- [Go Server](#go-server)
- [Go Client](#go-client)
- [Ruby Client](#ruby-client)
- [Javascript Web Client](#javascript-web-client)

## Proto
```proto
syntax = "proto3";

package hello;

service HelloService {
  rpc SayHello (HelloRequest) returns (HelloReply);
}

message HelloRequest {
  string name = 1;
}

message HelloReply {
  string message = 1;
}
```

## Go Server

```shell
. run.sh compile_protos
. run.sh go_server
```

```go
func (server *grpc_server) SayHello(
  ctx context.Context, args *pb.HelloRequest) (*pb.HelloReply, error) {

  return &pb.HelloReply{
    Message: "hello " + args.Name + "!"}, nil
}

server := buildServer()

listenServer(server, "50051")
```

## Go Client
```shell
. run.sh go_client
```

```go
_, client := buildClient("localhost:50051")

response, _ := client.SayHello(
  context.Background(), &pb.HelloRequest{Name: "gbaptista"})

response.Message // 'hello gbaptista!'
```

## Ruby Client
```shell
. run.sh ruby_client
```

```ruby
client = Hello::Client.new(
  'localhost:50051',
  :this_channel_is_insecure
)

response = client.say_hello(
  Hello::HelloRequest.new(name: 'gbaptista')
)

response.message # => 'hello gbaptista!'
```

## Javascript Web Client
```shell
docker-compose up -d

cd src/web_js_client/

npm install
npm start

> http://localhost:8080
```

```es6
grpc_client = new HelloServiceClient(
  'http://localhost:50052'
);

const request = new HelloRequest();
request.setName('gbaptista');

grpc_client.sayHello(request, {}, (error, response) => {
  if(error) {
    console.error(error);
  } else {
    console.error(response); // 'hello gbaptista!'
  }
});
```
