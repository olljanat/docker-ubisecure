# ubisecure-proxy
ubisecure-proxy is NGINX which handles connections to docker networks

## Build
```bash
docker build -t ubisecure-proxy .
```

## Create service
```bash
docker service create --name ubisecure-proxy --network ubisecure -p 80:80 ubisecure-proxy
```
