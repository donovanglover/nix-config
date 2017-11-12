# Waterfox

## Command Mode

- Take a screenshot of the entire page          `screenshot --fullpage`
- Take a screenshot of the visible window only  `screenshot`
- Restart the browser                           `restart`

## Preferences

Waterfox has 2 preference files: `prefs.js` and `user.js`.

`prefs.js` are the settings defined by the browser and `user.js` is an optional file that you can create. `user.js` takes precedence over `prefs.js` and will replace the settings in `prefs.js` when Waterfox is started.

## Theme

Waterfox allows you to customize the appearance of the browser by creating your own `userChrome.css`. It is located inside of the `chrome` folder, which needs to be created by the user.
