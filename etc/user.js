/********************************************************************************\
*
*    New Start: A modern Arch workflow built with an emphasis on functionality.
*    Copyright (C) 2017 Donovan Glover
*    
*    This program is free software: you can redistribute it and/or modify
*    it under the terms of the GNU General Public License as published by
*    the Free Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*
*    You should have received a copy of the GNU General Public License
*    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*
\********************************************************************************/

// Remove the large bar that prompts for multiple search providers
// even when you only have one search provider enabled
user_pref("browser.search.hiddenOneOffs", false);
user_pref("browser.urlbar.oneOffSearches", false);

// Disable search suggestions
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.searchSuggestionsChoice", false);
user_pref("browser.urlbar.suggest.searches", false);
user_pref("browser.urlbar.timesBeforeHidingSuggestionsHint", 0);

// Use the light devtools theme and open it in a new window
user_pref("devtools.theme", "light");
user_pref("devtools.toolbox.host", "window");
user_pref("devtools.toolbox.selectedTool", "inspector");

// Enable scrolling by holding down the middle mouse button
user_pref("general.autoScroll", true);

// ============================================================================
// Other disabled content
// ============================================================================

// Disable web notifications
user_pref("dom.webnotifications.enabled", false);

// Disable location-aware browsing
user_pref("geo.enabled", false);

// Disable screen sharing, audio capture, and video capture
user_pref("media.navigator.video.enabled", false);
user_pref("media.getusermedia.screensharing.enabled", false);
user_pref("media.getusermedia.audiocapture.enabled", false);

// Disable speech recognition and synthesis
user_pref("media.webspeech.recognition.enable", false);
user_pref("media.webspeech.synth.enabled", false);

// Disable the gamepad API
user_pref("dom.gamepad.enabled", false);

// Disable the VR API
user_pref("dom.vr.enabled", false);

// Disable the vibrator API
user_pref("dom.vibrator.enabled", false);

// Disable other video features
user_pref("camera.control.face_detection.enabled", false);

// Set the default search engine to DuckDuckGo
user_pref("browser.search.defaultenginename", "DuckDuckGo");
user_pref("browser.search.order.1", "DuckDuckGo");
user_pref("keyword.URL", "https://duckduckgo.com/html/?q=!+");

// Explicitly declare the region for searches
user_pref("browser.search.countryCode", "US");
user_pref("browser.search.region", "US");
user_pref("browser.search.geoip.url", "");

// Always request the english version of a webpage
user_pref("intl.accept_languages", "en-us, en");
