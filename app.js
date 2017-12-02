;(function(window, document, undefined) {

    "use strict";

    // Open all external links in new tabs
    var links = document.getElementsByTagName("a");

    for(var i = 0; i < links.length; i++) {
        var thisLink = links[i];
        if(thisLink.getAttribute("href") && thisLink.hostName !== location.hostname) {
            thisLink.target = "_blank";
        }
    }

})(window, document);
