require 'grpc'
require './src/protos/compiled_ruby/hello_pb'

module Hello
  class Service
    include GRPC::GenericService

    self.marshal_class_method = :encode
    self.unmarshal_class_method = :decode
    self.service_name = 'hello.HelloService'

    rpc :SayHello, HelloRequest, HelloReply
  end

  Client = Service.rpc_stub_class
end
