docker-hubot-torrent
====================

```shell
sudo docker run --name redis-app -v /yourdirectory/data:/data -d redis
sudo docker run --name hubot-torrent -e REDIS_URL="redis://172.17.0.2:6379" -e HUBOT_GTALK_USERNAME="your@gmail.com" -e HUBOT_GTALK_PASSWORD="password" --link redis-app:redis -d dnesteryuk/docker-hubot-torrent
```
