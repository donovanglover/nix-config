# gtk-settings

[GTK][gtk] is the widget toolkit used by Firefox, Electron, and many (if not all) GNOME applications.

GTK's `settings.ini` only affects window managers and not the GNOME desktop environment. This is because GNOME manages user preferences with [`dconf` through `gsettings`][gnome].

## Use Cases

gtk-settings can be used to:

- Control the appearance of GTK applications under non-GNOME environments

You do not need to use gtk-settings if:

- You are using the GNOME desktop environment

[gtk]: https://wiki.archlinux.org/index.php/GTK+
[gnome]: https://wiki.archlinux.org/index.php/GNOME#Configuration
