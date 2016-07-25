#!/bin/bash
CURRENT_DIR=$(pwd)

# Build
docker build -t devdock .

# Kill the previous one
docker kill devdock
docker rm devdock

####    Create docker container with the created image ####
#         3000:3000 for Community Hub
#         3001:3001 for Webpack development server
#         5999:5999 for VNC
#         4444:4444 for Selenium server
###########################################################

#CONTAINER_ID=$(docker run -it --privileged -p 8080:8080 -p 3000:3000 -p 3001:3001 -p 4444:4444 -p 5999:5999 -d devdock)
#CONTAINER_ID=$(docker run -it -u devdock --privileged -p 8080:8080 -p 3000:3000 -p 3001:3001 -p 4444:4444 -p 5999:5999 -v /Users/nowy.condro/workspace:/home/devdock/ devdock '/bin/bash')

# To detach
echo
echo
echo

docker run -it -u devdock \
  --privileged --name devdock \
  -p 8080:8080 -p 3000:3000 -p 3001:3001 -p 4444:4444 -p 5999:5999 \
  -w /home/devdock/ \
  -v $CURRENT_DIR/workspace:/home/devdock/workspace devdock '/bin/bash'
#docker exec -it -u devdock $CONTAINER_ID /bin/bash
#cat containerid | xargs docker attach


# To start
# docker run --privileged -p 3000:3000 -p 3001:3001 -p 4444:4444 -p 5999:5999 -d devdock

# To SSH 
# docker exec -it -u devdock CONTAINER_ID /bin/bash       #by ID
# docker exec -it -u devdock CONTAINER_NAME /bin/bash     #by Name

# To attach
# docker attach <CONTAINER_ID>

# To detach
# Hit "Ctrl+P+Q"


# Shutdown selenium server
# http://localhost:4444/selenium-server/driver/?cmd=shutDownSeleniumServer

# Clean Docker space
# docker ps -a | sed '1 d' | awk '{print $1}' | xargs -L1 docker rm
# docker rmi $(docker images -a | grep "^<none>" | awk -F$' ' '{print $3}')

# Backup
# docker run --privileged -itd -p 3000:3000 -p 5999:5999 -p 4444:4444 -v /Users/nowy.condro/workspace:/home/devdock/ devdock '/bin/bash'