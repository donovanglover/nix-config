install=sudo dnf install --assumeyes
copr=sudo dnf copr enable --assumeyes

.PHONY: all
all: rice RPMs/muya.rpm install kitty wal clean

.PHONY: rice
rice:
	@${install} pop-gtk-theme pop-icon-theme breeze-cursor-theme
	@../gnome/.config/gnome/extensions.sh
	@../gnome/.config/gnome/antialiasing.sh
	@../gnome/.config/gnome/pop-gtk-theme.sh
	@../gnome/.config/gnome/breeze-cursor-theme.sh

.ONESHELL:
RPMs/muya.rpm: RPMs/muya.spec
	@cd RPMs
	@rm -rfv noarch
	@fedpkg --release f29 local
	@mv noarch/*.rpm muya.rpm
	@rmdir noarch
	@rm -fv *.src.rpm

.PHONY: install
install:
	@${install} RPMs/muya.rpm

.PHONY: kitty
kitty:
	@${copr} gagbo/kitty-latest
	@${install} kitty

.PHONY: wal
wal:
	@pip3 install --user pywal

.PHONY: clean
clean:
	@rm -rv ~/rpmbuild
