package main

func main() {
	server := buildServer()

	listenServer(server, "50051")
}
