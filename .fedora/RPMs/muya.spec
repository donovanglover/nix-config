Name: muya
Version: 0.2.0
Release: 1%{?dist}
Summary: Packages I use in addition to the defaults on Fedora
License: Various
BuildArch: noarch

# Packages
Requires: stow
Requires: neovim
Requires: vim-enhanced
Requires: fish
Requires: pass
Requires: ripgrep
Requires: fzf
Requires: exa
Requires: fd-find
Requires: httpie
Requires: jq
Requires: ranger
Requires: tig
Requires: youtube-dl
Requires: neofetch
Requires: cmatrix
Requires: borgbackup
Requires: rsync
Requires: texlive
Requires: nginx
Requires: nodejs
Requires: nodejs-yarn
Requires: java-11-openjdk
Requires: ansible
Requires: docker
Requires: docker-compose
Requires: chromium

%description
All the packages and other options I use on a fresh Fedora machine.
Keeping one package and updating it as time goes on makes it easy to
manage dependencies and other installed files.

%files
%{_bindir}/256colortest
%{_bindir}/colorfade
%{_bindir}/colorhash
%{_bindir}/colorhex
%{_bindir}/colorline
%{_bindir}/colorpanes
%{_bindir}/colortest
%{_bindir}/diamonds
%{_bindir}/dna
%{_bindir}/ghosts
%{_bindir}/pipes
%{_bindir}/pmabove
%{_bindir}/pmleft
%{_bindir}/spaceinvaders
%{_bindir}/unowns

%install
ROOT_DIR=../../.archlinux/PKGBUILDs
SCRIPTS_DIR=$ROOT_DIR/tari-scripts
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/256colortest
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/colorfade
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/colorhash
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/colorhex
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/colorline
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/colorpanes
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/colortest
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/diamonds
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/dna
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/ghosts
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/pipes
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/pmabove
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/pmleft
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/spaceinvaders
install -Dm 755 -t %{buildroot}/%{_bindir} $SCRIPTS_DIR/unowns
