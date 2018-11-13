muya.rpm: muya.spec
	@sudo dnf install -y fedpkg
	@rm -rfv noarch
	@fedpkg --release f29 local
	@mv noarch/*.rpm muya.rpm
	@rmdir noarch

.PHONY: install-muya
install-muya:
	@sudo dnf install muya.rpm

.PHONY: clean
clean:
	@rm -fv **/*.pkg.tar.xz
	@rm -fv **/*.xpi
	@rm -fv **/*.tar.gz
	@rm -fv **/*.tar.bz2
	@rm -fv **/*.vim
