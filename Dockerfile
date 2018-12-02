FROM envoyproxy/envoy-alpine:latest

COPY envoy.yaml /etc/envoy.yaml
COPY envoy.sh /envoy.sh

CMD /usr/local/bin/envoy -c /etc/envoy.yaml

ENTRYPOINT ["sh", "envoy.sh"]
