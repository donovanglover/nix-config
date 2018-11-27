.PHONY: install
install:
	@cd PKGBUILDs/${package} && makepkg -scif --noconfirm

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
