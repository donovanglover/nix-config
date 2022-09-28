# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2018 Donovan Glover
#
# Usage:
# make              Defaults to `make install`
# make install      Installs dotfiles
# make uninstall    Uninstalls dotfiles
# make prune        Removes stale links

verbose          ?= 1
NS_REPO_PATH     := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NS_STOW_OPTIONS  := --dir="${NS_REPO_PATH}" --target="${HOME}" --no-folding --verbose=${verbose}
NS_STOW_PACKAGES := $(wildcard */)
NS_SUCCESS       := "SUCCESS: Stow command executed succesfully!"
NS_STOW_COMMAND  := $(if ${package},ns_stow_package,ns_stow_all)

ns_stow_package =                                                                                          \
	echo "STATUS: Found package variable. Stow operation will be performed if it is a valid directory..."; \
	test -d ${package} &&                                                                                  \
	(stow -${1} ${package} ${NS_STOW_OPTIONS} &&                                                           \
	echo ${NS_SUCCESS}) ||                                                                                 \
	echo "FAILURE: Not a valid package directory."

ns_stow_all =                                                                                              \
	echo "STATUS: No package variable given. Performing stow operation on all directories...";             \
	$(foreach package,$(NS_STOW_PACKAGES),stow -${1} $(package) ${NS_STOW_OPTIONS} &&)                     \
	echo ${NS_SUCCESS}

.PHONY: install
install:
	@$(call ${NS_STOW_COMMAND},S)

.PHONY: uninstall
uninstall:
	@$(call ${NS_STOW_COMMAND},D)

.PHONY: prune
prune:
	@$(call ${NS_STOW_COMMAND},R)

.PHONY: enable-ssh-agent
enable-ssh-agent:
	@systemctl --user enable --now ssh-agent.service
