This Docker project is based in load balancing and proxying with a traefik container between 2 backend containers, front and wordpress.

All traffic connections are handled by the traefik container in mode host, and routed to the specific backend using the labels in the docker-compose.yml.
The traefik also manages Let's Encrypt certificates and stores them in in the acme.json file.
