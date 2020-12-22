# Try noVNC

Use [noVNC](https://novnc.com) to interact with windows manager in a docker
container.

## tl;dr

    docker-compose up

And visit <http://localhost:9876/vnc.html>

When password protected, get password with

    docker exec -it arch-i3 cat /app/.vnc/passwdfile

## rebuild

    docker-compose up -d --build arch-i3

## troubleshoot

See container logs

    docker logs arch-fluxbox

Connect to container

    docker exec -it arch-fluxbox bash
