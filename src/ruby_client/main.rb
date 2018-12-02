require './src/ruby_client/client'

client = Hello::Client.new(
  'localhost:50051',
  :this_channel_is_insecure
)

response = client.say_hello(
  Hello::HelloRequest.new(name: 'gbaptista')
)

print(
  "\n SayHello('gbaptista') -> ",
  "'#{response.message}'\n\n"
)
