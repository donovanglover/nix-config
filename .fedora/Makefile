install=sudo dnf install --assumeyes
copr=sudo dnf copr enable --assumeyes

.PHONY: all
all: rice kitty wal

.PHONY: rice
rice:
	@${install} pop-gtk-theme pop-icon-theme breeze-cursor-theme
	@../gnome/.config/gnome/extensions.sh
	@../gnome/.config/gnome/antialiasing.sh
	@../gnome/.config/gnome/pop-gtk-theme.sh
	@../gnome/.config/gnome/breeze-cursor-theme.sh

.PHONY: kitty
kitty:
	@${copr} gagbo/kitty-latest
	@${install} kitty

.PHONY: wal
wal:
	@pip3 install --user pywal
