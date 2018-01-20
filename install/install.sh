# Note that the default password for your new account is the same as your username. Upon reboot, the X server should automatically start at login. Then:
#
# 1. Change the root password with `passwd`
# 2. Change the local account password with `passwd <username>`

# Turn error handling on so that any errors terminate the script
set -e

USAGE="Usage: ./install.sh <hostname> $1 <localuser> $2"

# ============= We're done configuring, now install our stuff =============

# Install all the vim plugins
# TODO: Download vim-plug before this so :PlugInstall works

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Make the undo dir so we can undo with the regular vim
mkdir ~/.vim/undo

# TODO: Ensure that this works during the install process
vim +PlugInstall +qall

# This is a placeholder of the structure needed to install crystal-ctags
git clone https://github.com/SuperPaintman/crystal-ctags
cd crystal-ctags
sudo make install # TODO: Is sudo required here?
