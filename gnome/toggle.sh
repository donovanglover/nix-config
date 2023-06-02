status=$(gsettings get org.gnome.shell enabled-extensions)

if [[ "$status" == *'hidetopbar@mathieu.bidon.ca'* ]]; then
  gnome-extensions disable hidetopbar@mathieu.bidon.ca
else
  gnome-extensions enable hidetopbar@mathieu.bidon.ca
fi
