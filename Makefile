# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2018 Donovan Glover
#
# Usage:
# make              Defaults to `make install`
# make install      Installs dotfiles
# make uninstall    Uninstalls dotfiles
# make prune        Removes stale links

verbose          ?= 2
NS_REPO_PATH     := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
NS_STOW_OPTIONS  := --dir="${NS_REPO_PATH}" --target="${HOME}" --no-folding --verbose=${verbose}
NS_STOW_PACKAGES := $(wildcard */)
NS_SUCCESS       := "SUCCESS: Stow command executed succesfully!"

ns_stow_package =                                                                                          \
	echo "STATUS: Found package variable. Stow operation will be performed if it is a valid directory..."; \
	test -d ${package} &&                                                                                  \
	(stow -${1} ${package} ${NS_STOW_OPTIONS} &&                                                           \
	echo ${NS_SUCCESS}) ||                                                                                 \
	echo "FAILURE: Not a valid target directory."

ns_stow_all =                                                                                              \
	echo "STATUS: No package variable given. Performing stow operation on all directories...";             \
	$(foreach package,$(NS_STOW_PACKAGES),stow -${1} $(package) ${NS_STOW_OPTIONS} &&)                     \
	echo ${NS_SUCCESS}

.PHONY: install
install:
ifdef package
	@$(call ns_stow_package,S)
else
	@$(call ns_stow_all,S)
endif

.PHONY: uninstall
uninstall:
ifdef package
	@$(call ns_stow_package,D)
else
	@$(call ns_stow_all,D)
endif

.PHONY: prune
prune:
ifdef package
	@$(call ns_stow_package,R)
else
	@$(call ns_stow_all,R)
endif
