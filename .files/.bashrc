#!/bin/bash
source ./.bash_profile

clear
echo Welcome $(whoami)
echo
echo
echo VNC starting
export DISPLAY=:99
Xvfb :99 -shmem -screen 0 1366x768x16 > /dev/null 2>&1 &
x11vnc -passwd vnc -shared -display :99 -N -forever > /dev/null 2>&1 &
echo VNC started on port 5999 with password vnc
echo
echo Selenium starting
selenium-standalone start > /dev/null 2>&1 &
echo Selenium started on port 4444
echo
echo Tips :
echo - Hit "Ctrl+p+q" to detach, or "Ctrl+q" to quit
echo - Use ~/workspace folder to start your work
echo - "<HOST>./workspace" folder mounted to "<DOCKER>~/workspace"
echo - Run "'sh ~/workspace/build-fe.sh'" to build Community Hub FE





echo

