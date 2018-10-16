# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2018 Donovan Glover
#
# Usage:
# make              Defaults to `make install`
# make install      Installs dotfiles
# make uninstall    Uninstalls dotfiles
# make prune        Removes stale links

NS_REPO_PATH    := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NS_REPO_DIR     := $(shell basename $(NS_REPO_PATH))
NS_PARENT_PATH  := $(shell dirname $(NS_REPO_PATH))
NS_STOW_OPTIONS := "${NS_REPO_DIR}" --dir="${NS_PARENT_PATH}" --target="${HOME}" --no-folding --verbose=2

.PHONY: install
install:
	stow -S ${NS_STOW_OPTIONS}

.PHONY: uninstall
uninstall:
	stow -D ${NS_STOW_OPTIONS}

.PHONY: prune
prune:
	stow -R ${NS_STOW_OPTIONS}
