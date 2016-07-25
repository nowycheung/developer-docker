#!/bin/bash
export DISPLAY=:99
Xvfb :99 -shmem -screen 0 1366x768x16 &
x11vnc -passwd vnc -shared -display :99 -N -forever &

#su - devdoc -c "cd /home/devdoc && git clone https://nowy.condro@git.netent.com/scm/ch/community-hub-frontend.git"
#su - devdoc -c "cd /home/devdoc/community-hub-frontend && npm i && npm rebuild node-sass"

# selenium must be started by a non-root user otherwise chrome can't start
su - devdoc -c "selenium-standalone start"

# Start the CH-FE
# su - devdoc -c "cd ~/community-hub-frontend && npm run dev"

# Start the CH-FE
su - devdoc -c "cd ~/community-hub-frontend && npm run dev"


# > /dev/null 2>&1 &