# Note: some settings use dconf since no gsettings option is available (e.g. extensions)

echo "Make fonts look nice..."
gsettings set org.gnome.desktop.interface font-antialiasing "rgba"
gsettings set org.gnome.desktop.interface font-hinting "full"

echo "GTK + Cursor + Icon theme..."
gsettings set org.gnome.desktop.interface icon-theme "Fluent"

echo "Touchpad settings..."
gsettings set org.gnome.desktop.peripherals.touchpad click-method "fingers"
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
gsettings set org.gnome.desktop.peripherals.touchpad accel-profile "flat"

echo "Don't dim the screen or sleep if inactive..."
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false

echo "Performance by default..."
gsettings set org.gnome.shell last-selected-power-profile 'performance'

echo "Enable extensions..."
gsettings set org.gnome.shell enabled-extensions "['just-perfection-desktop@just-perfection']"

echo "Disable appgrid (except for super+a and 3 finger up gesture)"
dconf write /org/gnome/shell/extensions/just-perfection/double-super-to-appgrid false
dconf write /org/gnome/shell/extensions/just-perfection/show-apps-button false

echo "Don't show apps on startup"
dconf write /org/gnome/shell/extensions/just-perfection/startup-status 0

echo "Enable ibus/mozc..."
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'mozc-jp')]"
