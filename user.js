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
