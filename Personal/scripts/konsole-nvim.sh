#!/bin/bash
## ~/.local/bin/konsole-shell
#if [ "$LAUNCH_NVIM" = "1" ]; then
#  unset LAUNCH_NVIM
#  echo "$LAUNCH_NVIM" &>>~/log.log
#  exec nvim
#fi
#exec $SHELL

SHELL=fish
LOCKFILE="$HOME/.cache/.konsole-nvim-launched-$KONSOLE_DBUS_SERVICE"

if [ ! -f "$LOCKFILE" ]; then
  touch "$LOCKFILE"
  nvim
  rm "$LOCKFILE"
  exec $SHELL
fi
exec $SHELL
