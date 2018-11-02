# Muya - A light rice for Fedora

This is my setup for [Fedora][fedora], a [GNU/Linux][gnulinux] distribution that ships with GNOME by default, making it an ideal choice for most users. This guide covers a *simple* rice that will make your Fedora look much nicer than the defaults. It only uses packages from the official repositories, making it quick and easy to set up on any machine.

> This guide will work with the **latest version** of Fedora (29 as of this writing).

## Getting Started

### Step 1. Install packages

Run `make rice` to install the packages necessary to complete this rice.

### Step 2. Apply GNOME Tweaks

Open the GNOME Tweaks program. Then:

#### Under Appearance

1. Change **Applications** to **Pop** or **Pop-dark**.
2. Change **Cursor** to **Breeze_cursors**.
3. Change **Icons** to **Pop**.
4. Change the background and lock screen image.

#### Under Extensions

1. Check **Alternatetab** to enable previews on alt tab. Under settings, uncheck "Show only windows in the current workspace" to take advantage of alt tabbing between workspaces.
2. (Optional) Uncheck **Background logo** to remove the Fedora watermark from default wallpapers.
3. (Optional) Check **Places status indicator** to easily access your user directories.

#### Under Fonts

1. Change **Hinting** to **Full**.
2. Change **Antialiasing** to **Subpixel (for LCD screens)**.

### And you're done!

That's it. You now have a very simple Fedora rice. If you want to mimic my development setup as well, continue reading.

## Setting up Fedora for development work

> TODO: Write this section

[fedora]: https://getfedora.org
[gnulinux]: https://www.gnu.org/gnu/linux-and-gnu.html
