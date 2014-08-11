# Docker-hubot-torrent

It is an image containing [Hubot](/github/hubot) with already integrated [Hubot Torrent plugin](/dnesteryuk/hubot-torrent) which allows you to download files from torrents via [Transmission](http://www.transmissionbt.com/) which is managed through Hubot.

This image already contains a plugin for connecting to hubot via Gtalk. Therefore, to use it, you have to have a google account.

# Requirments

 - Docker ~> 1.0

# Installation

  1. Pull latest version of the image

  ```
    sudo docker pull dnesteryuk/docker-hubot-torrent
  ```

  2. Launch the hubot-torrent container

    All settings for HubotTorret should be passed through environment variables. Therefore, there are 2 ways to that. First one is through arguments while running a container:

  ```
    sudo docker run --name hubot-torrent -e HUBOT_GTALK_USERNAME="your@gmail.com" -e HUBOT_GTALK_PASSWORD="yourpassword" -e PSLAN_USERNAME="yourlogim" -e PSLAN_PASSWORD="yourpassword" -e RUTRACKER_LOGIN="yourlogin" -e RUTRACKER_PASSWORD="yourpassword" -v /path_to_save_files:/hubot_data hubot-torrent
  ```
  
  It is not reusable. Therefore, there is a posibility to save such options to a file and use it while running a container:
  
  ```
    sudo docker run --name hubot-torrent --env-file ./hubot_torrent.conf  -v /path_to_save_files:/hubot_data hubot-torrent
  ```

