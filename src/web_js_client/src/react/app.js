import React, { Component } from 'react';

import { HelloRequest } from '../protos/hello_pb'

import {
  HelloServiceClient
} from '../protos/hello_grpc_web_pb'

class App extends Component {
  constructor() {
    super();

    this.grpc_client = new HelloServiceClient(
      'http://localhost:50052'
    );

    this.state = { data: "loading..." }

    const request = new HelloRequest();
    request.setName('gbaptista');

    this.grpc_client.sayHello(request, {}, (error, response) => {
      if(error) {
        this.setState({
          data: `Error: ${error.message} (code ${error.code})`
        });
      } else {
        this.setState({ data: response.array[0] });
      }
    });
  }

  render() {
    return (
      <div>
        {this.state.data}
      </div>
    );
  }
};

export default App;
