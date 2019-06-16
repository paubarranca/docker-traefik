FROM haproxy:latest

ENV HAPROXY_USER haproxy

# Creating user and group haproxy sepecified in the config file
RUN groupadd --gid 49971 --system ${HAPROXY_USER} && \
  useradd --system --uid 49971 --gid ${HAPROXY_USER} ${HAPROXY_USER} && \
  mkdir --parents /var/lib/${HAPROXY_USER} && \
  chown -R ${HAPROXY_USER}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}

RUN apt-get update && apt-get install -y --no-install-recommends libcap2-bin  && rm -rf /var/lib/apt/lists/*
RUN setcap 'cap_net_bind_service=+ep' /usr/local/sbin/haproxy

USER haproxy

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

 

