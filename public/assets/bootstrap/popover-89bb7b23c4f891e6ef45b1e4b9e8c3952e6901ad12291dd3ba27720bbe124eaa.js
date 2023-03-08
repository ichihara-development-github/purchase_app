/*!
  * Bootstrap popover.js v4.6.0 (https://getbootstrap.com/)
  * Copyright 2011-2021 The Bootstrap Authors (https://github.com/twbs/bootstrap/graphs/contributors)
  * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)
  */
!function(t,e){"object"==typeof exports&&"undefined"!=typeof module?module.exports=e(require("jquery"),require("./tooltip.js")):"function"==typeof define&&define.amd?define(["jquery","./tooltip"],e):(t="undefined"!=typeof globalThis?globalThis:t||self).Popover=e(t.jQuery,t.Tooltip)}(this,function(t,e){"use strict";function n(t){return t&&"object"==typeof t&&"default"in t?t:{"default":t}}function o(t,e){for(var n=0;n<e.length;n++){var o=e[n];o.enumerable=o.enumerable||!1,o.configurable=!0,"value"in o&&(o.writable=!0),Object.defineProperty(t,o.key,o)}}function r(t,e,n){return e&&o(t.prototype,e),n&&o(t,n),t}function i(){return(i=Object.assign||function(t){for(var e=1;e<arguments.length;e++){var n=arguments[e];for(var o in n)Object.prototype.hasOwnProperty.call(n,o)&&(t[o]=n[o])}return t}).apply(this,arguments)}function u(t,e){t.prototype=Object.create(e.prototype),t.prototype.constructor=t,t.__proto__=e}var f=n(t),a=n(e),l="popover",s="4.6.0",c="bs.popover",p="."+c,d=f["default"].fn[l],h="bs-popover",y=new RegExp("(^|\\s)"+h+"\\S+","g"),g=i({},a["default"].Default,{placement:"right",trigger:"click",content:"",template:'<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-header"></h3><div class="popover-body"></div></div>'}),v=i({},a["default"].DefaultType,{content:"(string|element|function)"}),m="fade",E="show",b=".popover-header",C=".popover-body",T={HIDE:"hide"+p,HIDDEN:"hidden"+p,SHOW:"show"+p,SHOWN:"shown"+p,INSERTED:"inserted"+p,CLICK:"click"+p,FOCUSIN:"focusin"+p,FOCUSOUT:"focusout"+p,MOUSEENTER:"mouseenter"+p,MOUSELEAVE:"mouseleave"+p},j=function(t){function e(){return t.apply(this,arguments)||this}u(e,t);var n=e.prototype;return n.isWithContent=function(){return this.getTitle()||this._getContent()},n.addAttachmentClass=function(t){f["default"](this.getTipElement()).addClass(h+"-"+t)},n.getTipElement=function(){return this.tip=this.tip||f["default"](this.config.template)[0],this.tip},n.setContent=function(){var t=f["default"](this.getTipElement());this.setElementContent(t.find(b),this.getTitle());var e=this._getContent();"function"==typeof e&&(e=e.call(this.element)),this.setElementContent(t.find(C),e),t.removeClass(m+" "+E)},n._getContent=function(){return this.element.getAttribute("data-content")||this.config.content},n._cleanTipClass=function(){var t=f["default"](this.getTipElement()),e=t.attr("class").match(y);null!==e&&e.length>0&&t.removeClass(e.join(""))},e._jQueryInterface=function(t){return this.each(function(){var n=f["default"](this).data(c),o="object"==typeof t?t:null;if((n||!/dispose|hide/.test(t))&&(n||(n=new e(this,o),f["default"](this).data(c,n)),"string"==typeof t)){if("undefined"==typeof n[t])throw new TypeError('No method named "'+t+'"');n[t]()}})},r(e,null,[{key:"VERSION",get:function(){return s}},{key:"Default",get:function(){return g}},{key:"NAME",get:function(){return l}},{key:"DATA_KEY",get:function(){return c}},{key:"Event",get:function(){return T}},{key:"EVENT_KEY",get:function(){return p}},{key:"DefaultType",get:function(){return v}}]),e}(a["default"]);return f["default"].fn[l]=j._jQueryInterface,f["default"].fn[l].Constructor=j,f["default"].fn[l].noConflict=function(){return f["default"].fn[l]=d,j._jQueryInterface},j});