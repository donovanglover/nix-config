# Changelog

## [Unreleased]

### New

- The bspwm session will now re-adjust and change DPI based on screen resolution
- The cursor size will now change based on DPI
- The fish prompt now also shows git tag information
- The default color scheme is now base16-tomorrow-night

### Fixed

- Fixed an issue where the user had to restart the X session for the proper cursor size when using variable DPI
- Fixed an issue where non-HiDPI users would have to manually adjust ~/.Xresources to 96 DPI
- Fixed an issue where no wal theme would be set on a fresh install

## [0.2.0] (December 12th 2018)

### New

- Streamlined the Arch Linux installation process
- The Arch Linux bootstrap script works completely
- Combined meta packages into single PKGBUILD
- Removed window borders and gaps from the default setup
- The name of the focused window is now shown at the top of the screen
- Added bspwm-round-corners-git PKGBUILD
- Added some new git abbreviations and removed others
- Added git branch information to the fish prompt
- Added proper shadow settings for compton
- Added a script to re-create the environment on resolution change
- Added color to man pages
- Added KDE theme support without having to set it manually through Plasma's system settings
- Added variable DPI support to dropdown terminal and screenshot utility
- Changed the colors used by kitty to show which kitty window has focus
- Changed the bspwm desktop names for icons instead
- Increased the available working space for programs and other windows

### Fixed

- Fixed some issues in the Arch Linux install scripts
- Fixed an issue where GTK settings.ini incorrectly defined the cursor size
- Fixed an issue where polybar would sometimes use the incorrect background color
- Fixed tig showing illegible text with certain color schemes

## [0.1.0] (December 1st 2018)

- Finally settled on a file hierarchy
- The Fedora bootstrap script works completely
- Arch Linux install scripts work, but can be improved
- The actual rice works very well

[Unreleased]: https://github.com/GloverDonovan/.files/compare/0.2.0...HEAD
[0.2.0]: https://github.com/GloverDonovan/.files/compare/0.1.0...0.2.0
[0.1.0]: https://github.com/GloverDonovan/.files/tree/0.1.0
