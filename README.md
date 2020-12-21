# Try noVNC

Use [noVNC](https://novnc.com) to interact with windows manager in a docker
container.

## tl;dr

    docker-compose up

And visit <http://localhost:9876/vnc.html>

## rebuild

    docker-compose up -d --build

## troubleshoot

See container logs

    docker logs novnc

Connect to container

    docker exec -it novnc bash
