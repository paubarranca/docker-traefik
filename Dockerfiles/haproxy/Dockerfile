FROM haproxy:latest

RUN apt-get update && apt-get install -y --no-install-recommends libcap2-bin  && rm -rf /var/lib/apt/lists/*

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

EXPOSE 80 443 

