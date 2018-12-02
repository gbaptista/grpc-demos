./grpc-demos/bin/go_server &

/usr/bin/dumb-init -- /usr/local/bin/envoy --v2-config-only -l $loglevel -c /etc/envoy.yaml
