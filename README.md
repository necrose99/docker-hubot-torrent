# Docker-hubot-torrent

It is an image containing [Hubot](/github/hubot) with already integrated [Hubot Torrent plugin](/dnesteryuk/hubot-torrent) which allows you to download files from torrents via [Transmission](http://www.transmissionbt.com/) which is managed through Hubot.

This image already contains a plugin for connecting to hubot via Gtalk. Therefore, to use it, you have to have a google account.

# Requirments

 - Docker ~> 0.9.1

# Installation

1. Pull latest version of the image

```
  docker pull dnesteryuk/docker-hubot-torrent
```

2. Launch the hubot-torrent container

```
  sudo docker run --name hubot-torrent -e HUBOT_GTALK_USERNAME="your@gmail.com" -e HUBOT_GTALK_PASSWORD="yourpassword" -e PSLAN_USERNAME="yourlogim" -e PSLAN_PASSWORD="yourpassword" -e RUTRACKER_LOGIN="yourlogin" -e RUTRACKER_PASSWORD="yourpassword" -v /path_to_save_files:/hubot_data
```
