# Docker-hubot-torrent

It is an image containing [Hubot](https://github.com/github/hubot) with already integrated [Hubot Torrent plugin](https://github.com/dnesteryuk/hubot-torrent) which allows you to download files from torrents via [Transmission](http://www.transmissionbt.com/).

This image already contains a plugin for connecting to Hubot via Gtalk (Hangout). Therefore, to use it, you have to have a google account.

# Requirments

 - Docker ~> 1.0

# Installation

  1. Pull latest version of the image

  ```bash
    sudo docker pull dnesteryuk/docker-hubot-torrent
  ```

  2. Launch the hubot-torrent container

    All settings for HubotTorrent should be passed through environment variables. Therefore, there are 2 ways to do that. The first one is through arguments while running a container:

  ```bash
    sudo docker run --name hubot-torrent -e HUBOT_GTALK_USERNAME="your@gmail.com" -e HUBOT_GTALK_PASSWORD="yourpassword" -e PSLAN_USERNAME="yourlogim" -e PSLAN_PASSWORD="yourpassword" -e RUTRACKER_LOGIN="yourlogin" -e RUTRACKER_PASSWORD="yourpassword" -v /path_to_save_files:/hubot_data hubot-torrent
  ```
  
  It is not reusable. Therefore, there is a posibility to save such options to a file and use it while running a container:
  
  ```bash
    sudo docker run --name hubot-torrent --env-file ./hubot_torrent.conf  -v /path_to_save_files:/hubot_data hubot-torrent
  ```
  
  Example of the config file can be found [here](https://github.com/dnesteryuk/docker-hubot-torrent/blob/master/hubot_torrent.conf.example)

