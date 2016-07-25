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
# Move the selenium into screen tab 3
# selenium-standalone start > /dev/null 2>&1 &
echo Selenium started on port 4444
echo
echo Tips :
echo - Hit "Ctrl+a, then escape" + "Ctrl+u"/"Ctrl+d" to scroll up/down in screen mode
echo - Hit "Ctrl+p+q" to detach, or "Ctrl+q" to quit
echo - Use ~/workspace folder to start your work
echo - "<HOST>./workspace" folder mounted to "<DOCKER>~/workspace"

echo

if [ -z "$STARTED_SCREEN" ]
then
  case $- in
    (*i*)
      STARTED_SCREEN=1; export STARTED_SCREEN
      screen -RR -U -S main  ||
        echo >&2 "Screen failed! continuing with normal bash startup"
  esac
fi
