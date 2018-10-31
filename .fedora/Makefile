install=sudo dnf install --assumeyes
make=$(MAKE) -C ..

# Other GTK themes: adapta-gtk-theme evopop-gtk-theme
# Other icon themes: numix-icon-theme-circle paper-icon-theme
# NOTE: You should use Pop in Fedora 29+ since Adapta and EvoPop
# 		have padding issues that presumably have not been updated
# 		yet for the latest version of GNOME.
.PHONY: rice
rice:
	@${install} gnome-tweaks pop-gtk-theme pop-icon-theme \
		breeze-cursor-theme

.PHONY: dev
dev:
	@${install} tmux vim neovim fish exa ripgrep

.PHONY: dotfiles
dotfiles:
	@${make} package=tmux
	@${make} package=fish
