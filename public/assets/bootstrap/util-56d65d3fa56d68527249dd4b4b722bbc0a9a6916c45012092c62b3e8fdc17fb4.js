/*!
  * Bootstrap util.js v4.6.0 (https://getbootstrap.com/)
  * Copyright 2011-2021 The Bootstrap Authors (https://github.com/twbs/bootstrap/graphs/contributors)
  * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)
  */
!function(t,e){"object"==typeof exports&&"undefined"!=typeof module?module.exports=e(require("jquery")):"function"==typeof define&&define.amd?define(["jquery"],e):(t="undefined"!=typeof globalThis?globalThis:t||self).Util=e(t.jQuery)}(this,function(t){"use strict";function e(t){return t&&"object"==typeof t&&"default"in t?t:{"default":t}}function n(t){return null==t?""+t:{}.toString.call(t).match(/\s([a-z]+)/i)[1].toLowerCase()}function r(){return{bindType:a,delegateType:a,handle:function(t){return u["default"](t.target).is(this)?t.handleObj.handler.apply(this,arguments):undefined}}}function o(t){var e=this,n=!1;return u["default"](this).one(d.TRANSITION_END,function(){n=!0}),setTimeout(function(){n||d.triggerTransitionEnd(e)},t),this}function i(){u["default"].fn.emulateTransitionEnd=o,u["default"].event.special[d.TRANSITION_END]=r()}var u=e(t),a="transitionend",f=1e6,l=1e3,d={TRANSITION_END:"bsTransitionEnd",getUID:function(t){do{t+=~~(Math.random()*f)}while(document.getElementById(t));return t},getSelectorFromElement:function(t){var e=t.getAttribute("data-target");if(!e||"#"===e){var n=t.getAttribute("href");e=n&&"#"!==n?n.trim():""}try{return document.querySelector(e)?e:null}catch(r){return null}},getTransitionDurationFromElement:function(t){if(!t)return 0;var e=u["default"](t).css("transition-duration"),n=u["default"](t).css("transition-delay"),r=parseFloat(e),o=parseFloat(n);return r||o?(e=e.split(",")[0],n=n.split(",")[0],(parseFloat(e)+parseFloat(n))*l):0},reflow:function(t){return t.offsetHeight},triggerTransitionEnd:function(t){u["default"](t).trigger(a)},supportsTransitionEnd:function(){return Boolean(a)},isElement:function(t){return(t[0]||t).nodeType},typeCheckConfig:function(t,e,r){for(var o in r)if(Object.prototype.hasOwnProperty.call(r,o)){var i=r[o],u=e[o],a=u&&d.isElement(u)?"element":n(u);if(!new RegExp(i).test(a))throw new Error(t.toUpperCase()+': Option "'+o+'" provided type "'+a+'" but expected type "'+i+'".')}},findShadowRoot:function(t){if(!document.documentElement.attachShadow)return null;if("function"==typeof t.getRootNode){var e=t.getRootNode();return e instanceof ShadowRoot?e:null}return t instanceof ShadowRoot?t:t.parentNode?d.findShadowRoot(t.parentNode):null},jQueryDetection:function(){if("undefined"==typeof u["default"])throw new TypeError("Bootstrap's JavaScript requires jQuery. jQuery must be included before Bootstrap's JavaScript.");var t=u["default"].fn.jquery.split(" ")[0].split("."),e=1,n=2,r=9,o=1,i=4;if(t[0]<n&&t[1]<r||t[0]===e&&t[1]===r&&t[2]<o||t[0]>=i)throw new Error("Bootstrap's JavaScript requires at least jQuery v1.9.1 but less than v4.0.0")}};return d.jQueryDetection(),i(),d});