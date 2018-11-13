THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
install=sudo dnf install --assumeyes
make=$(MAKE) -C ..
makeh=$(MAKE) -f $(THIS_MAKEFILE)

.PHONY: all
all:
	@${makeh} RPMs/muya.rpm
	@${makeh} install
	@${makeh} wal
	@${makeh} crystal
	@${makeh} rust
	@${makeh} diff-so-fancy
	@${makeh} dotfiles

.PHONY: rice
rice:
	@${install} gnome-tweaks pop-gtk-theme pop-icon-theme breeze-cursor-theme

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

.PHONY: dotfiles
dotfiles:
	@${make} package=tmux
	@${make} package=fish

.PHONY: wal
wal:
	@sudo pip3 install pywal

.PHONY: crystal
crystal:
	@sudo ./vendor/crystal-setup.sh
	@${install} crystal

.PHONY: rust
rust:
	@./vendor/rustup-init.sh

.PHONY: diff-so-fancy
diff-so-fancy:
	@sudo install -Dm 755 ./vendor/diff-so-fancy /usr/bin/diff-so-fancy

.PHONY: update
update:
	@mkdir -pv vendor
	@curl -L https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -o vendor/diff-so-fancy
	@curl -L https://sh.rustup.rs -o vendor/rustup-init.sh
	@curl -L https://dist.crystal-lang.org/rpm/setup.sh -o vendor/crystal-setup.sh
	@chmod 755 vendor/diff-so-fancy
	@chmod 755 vendor/rustup-init.sh
	@chmod 755 vendor/crystal-setup.sh
