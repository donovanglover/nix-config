.PHONY: install
install:
	@cd PKGBUILDs/${package} && makepkg -scif --noconfirm

.ONESHELL:
aur:
	@mkdir -p .aur && cd .aur
	@git clone "https://aur.archlinux.org/${package}.git"
	@cd ${package}
	@echo "==================================== Viewing ${package}"
	@cat PKGBUILD
	@echo "===================================="
	@echo -n "Press enter to continue, or Ctrl+C to quit. " && read
	@makepkg -sc
	@sudo pacman -U *.pkg.tar.xz

.PHONY: update-keys
update-keys:
	@sudo pacman-key --populate
	@sudo pacman-key --refresh-keys

.PHONY: clean
clean:
	@rm -fv **/*.pkg.tar.xz
	@rm -fv **/*.xpi
	@rm -fv **/*.tar.gz
	@rm -fv **/*.tar.bz2
	@rm -fv **/*.vim
	@rm -rfv .aur
