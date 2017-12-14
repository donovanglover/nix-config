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

    var randomize = function(id) {
        var list = document.getElementById(id);
        for(var i = list.children.length; i > -1; i--) {
            list.appendChild(list.children[Math.random() * i | 0]);
        }
    }

})(window, document);
