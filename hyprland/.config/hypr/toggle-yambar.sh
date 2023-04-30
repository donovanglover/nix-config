#!/bin/sh

if [[ -f "/tmp/yambar.pid" ]]; then
  killall yambar
  rm "/tmp/yambar.pid"
else
  launch yambar >> /tmp/yambar.pid
fi
