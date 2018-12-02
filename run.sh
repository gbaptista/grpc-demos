if [ -n "$1" ]; then
    PROJECT=$1;
else
    PROJECT=go_server;
fi

GOPATH=`pwd` go get google.golang.org/grpc
GOPATH=`pwd` go get github.com/golang/protobuf/proto

if [ "$PROJECT" == "compile_protos" ]
then

  GOPATH=`pwd` go get github.com/golang/protobuf/protoc-gen-go

  if [ ! -f /usr/local/bin/protoc-gen-grpc-web ]
  then
    sudo wget \
      -nc https://github.com/grpc/grpc-web/releases/download/1.0.3/protoc-gen-grpc-web-1.0.3-linux-x86_64 \
      -O /usr/local/bin/protoc-gen-grpc-web

    sudo chmod +x /usr/local/bin/protoc-gen-grpc-web
  fi

  GOPATH=`pwd` protoc -I src/protos/ \
    src/protos/hello.proto \
    --go_out=plugins=grpc:src/protos/compiled_go/hello/ \
    --ruby_out=plugins=grpc:src/protos/compiled_ruby/ \
    --js_out=import_style=commonjs:src/protos/compiled_js/ \
    --grpc-web_out=import_style=commonjs,mode=grpcweb:src/protos/compiled_js/ \

  # https://github.com/grpc/grpc-web
  yes | cp src/protos/compiled_js/* src/web_js_client/src/protos >/dev/null 2>&1

elif [ "$PROJECT" == "ruby_client" ]
then

  ruby src/ruby_client/main.rb

else
  
  go fmt src/$PROJECT/main.go && \
    GOPATH=`pwd` go install $PROJECT && \
    clear && \
    echo ./bin/$PROJECT: && 
    ./bin/$PROJECT
fi
