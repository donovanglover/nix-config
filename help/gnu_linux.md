# The GNU/Linux System

This file holds information about GNU/Linux in general.

## Root file structure

```
/               # Root directory
/bin            # Binaries for global commands (ls, cat, etc.)
/boot           # Boot loader files (grub, the linux kernel, etc.)
/dev            # "Device files" (/dev/null, /dev/random, etc.)
/etc            # System-wide configuration files
/home           # Saved files and personal settings of each user
/lib            # Libraries used by the binaries in /bin
/lib64          # 64-bit libraries
/mnt            # Temporarily mounted filesystems reside here
/opt            # Applications that don't rely on other dependencies
/proc           # Provides process and kernel information as files
/root           # Home directory for the root user
/run            # Information about the running system since last boot
/sbin           # System binaries (fsck, init, route, etc.)
/srv            # Site-specific data served by the system
/sys            # Contains information about the system
/tmp            # Temporary files used for processes
/usr            # Applications that rely on other dependencies
/var            # Variable files that are supposed to change over time
```
