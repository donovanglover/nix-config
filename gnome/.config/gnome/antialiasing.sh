#!/bin/sh

# Use the 'best' antialiasing settings for modern displays
gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing rgba
gsettings set org.gnome.settings-daemon.plugins.xsettings hinting full
