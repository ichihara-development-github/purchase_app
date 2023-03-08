/*!
  * Bootstrap collapse.js v4.6.0 (https://getbootstrap.com/)
  * Copyright 2011-2021 The Bootstrap Authors (https://github.com/twbs/bootstrap/graphs/contributors)
  * Licensed under MIT (https://github.com/twbs/bootstrap/blob/main/LICENSE)
  */
!function(e,t){"object"==typeof exports&&"undefined"!=typeof module?module.exports=t(require("jquery"),require("./util.js")):"function"==typeof define&&define.amd?define(["jquery","./util"],t):(e="undefined"!=typeof globalThis?globalThis:e||self).Collapse=t(e.jQuery,e.Util)}(this,function(e,t){"use strict";function n(e){return e&&"object"==typeof e&&"default"in e?e:{"default":e}}function l(e,t){for(var n=0;n<t.length;n++){var l=t[n];l.enumerable=l.enumerable||!1,l.configurable=!0,"value"in l&&(l.writable=!0),Object.defineProperty(e,l.key,l)}}function a(e,t,n){return t&&l(e.prototype,t),n&&l(e,n),e}function i(){return(i=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var l in n)Object.prototype.hasOwnProperty.call(n,l)&&(e[l]=n[l])}return e}).apply(this,arguments)}var r=n(e),s=n(t),o="collapse",u="4.6.0",f="bs.collapse",d="."+f,g=".data-api",c=r["default"].fn[o],h={toggle:!0,parent:""},_={toggle:"boolean",parent:"(string|element)"},m="show"+d,p="shown"+d,y="hide"+d,v="hidden"+d,C="click"+d+g,A="show",T="collapse",E="collapsing",j="collapsed",S="width",b="height",q=".show, .collapsing",w='[data-toggle="collapse"]',D=function(){function e(e,t){this._isTransitioning=!1,this._element=e,this._config=this._getConfig(t),this._triggerArray=[].slice.call(document.querySelectorAll('[data-toggle="collapse"][href="#'+e.id+'"],[data-toggle="collapse"][data-target="#'+e.id+'"]'));for(var n=[].slice.call(document.querySelectorAll(w)),l=0,a=n.length;l<a;l++){var i=n[l],r=s["default"].getSelectorFromElement(i),o=[].slice.call(document.querySelectorAll(r)).filter(function(t){return t===e});null!==r&&o.length>0&&(this._selector=r,this._triggerArray.push(i))}this._parent=this._config.parent?this._getParent():null,this._config.parent||this._addAriaAndCollapsedClass(this._element,this._triggerArray),this._config.toggle&&this.toggle()}var t=e.prototype;return t.toggle=function(){r["default"](this._element).hasClass(A)?this.hide():this.show()},t.show=function(){var t,n,l=this;if(!this._isTransitioning&&!r["default"](this._element).hasClass(A)&&(this._parent&&0===(t=[].slice.call(this._parent.querySelectorAll(q)).filter(function(e){return"string"==typeof l._config.parent?e.getAttribute("data-parent")===l._config.parent:e.classList.contains(T)})).length&&(t=null),!(t&&(n=r["default"](t).not(this._selector).data(f))&&n._isTransitioning))){var a=r["default"].Event(m);if(r["default"](this._element).trigger(a),!a.isDefaultPrevented()){t&&(e._jQueryInterface.call(r["default"](t).not(this._selector),"hide"),n||r["default"](t).data(f,null));var i=this._getDimension();r["default"](this._element).removeClass(T).addClass(E),this._element.style[i]=0,this._triggerArray.length&&r["default"](this._triggerArray).removeClass(j).attr("aria-expanded",!0),this.setTransitioning(!0);var o=function(){r["default"](l._element).removeClass(E).addClass(T+" "+A),l._element.style[i]="",l.setTransitioning(!1),r["default"](l._element).trigger(p)},u="scroll"+(i[0].toUpperCase()+i.slice(1)),d=s["default"].getTransitionDurationFromElement(this._element);r["default"](this._element).one(s["default"].TRANSITION_END,o).emulateTransitionEnd(d),this._element.style[i]=this._element[u]+"px"}}},t.hide=function(){var e=this;if(!this._isTransitioning&&r["default"](this._element).hasClass(A)){var t=r["default"].Event(y);if(r["default"](this._element).trigger(t),!t.isDefaultPrevented()){var n=this._getDimension();this._element.style[n]=this._element.getBoundingClientRect()[n]+"px",s["default"].reflow(this._element),r["default"](this._element).addClass(E).removeClass(T+" "+A);var l=this._triggerArray.length;if(l>0)for(var a=0;a<l;a++){var i=this._triggerArray[a],o=s["default"].getSelectorFromElement(i);if(null!==o)r["default"]([].slice.call(document.querySelectorAll(o))).hasClass(A)||r["default"](i).addClass(j).attr("aria-expanded",!1)}this.setTransitioning(!0);var u=function(){e.setTransitioning(!1),r["default"](e._element).removeClass(E).addClass(T).trigger(v)};this._element.style[n]="";var f=s["default"].getTransitionDurationFromElement(this._element);r["default"](this._element).one(s["default"].TRANSITION_END,u).emulateTransitionEnd(f)}}},t.setTransitioning=function(e){this._isTransitioning=e},t.dispose=function(){r["default"].removeData(this._element,f),this._config=null,this._parent=null,this._element=null,this._triggerArray=null,this._isTransitioning=null},t._getConfig=function(e){return(e=i({},h,e)).toggle=Boolean(e.toggle),s["default"].typeCheckConfig(o,e,_),e},t._getDimension=function(){return r["default"](this._element).hasClass(S)?S:b},t._getParent=function(){var t,n=this;s["default"].isElement(this._config.parent)?(t=this._config.parent,"undefined"!=typeof this._config.parent.jquery&&(t=this._config.parent[0])):t=document.querySelector(this._config.parent);var l='[data-toggle="collapse"][data-parent="'+this._config.parent+'"]',a=[].slice.call(t.querySelectorAll(l));return r["default"](a).each(function(t,l){n._addAriaAndCollapsedClass(e._getTargetFromElement(l),[l])}),t},t._addAriaAndCollapsedClass=function(e,t){var n=r["default"](e).hasClass(A);t.length&&r["default"](t).toggleClass(j,!n).attr("aria-expanded",n)},e._getTargetFromElement=function(e){var t=s["default"].getSelectorFromElement(e);return t?document.querySelector(t):null},e._jQueryInterface=function(t){return this.each(function(){var n=r["default"](this),l=n.data(f),a=i({},h,n.data(),"object"==typeof t&&t?t:{});if(!l&&a.toggle&&"string"==typeof t&&/show|hide/.test(t)&&(a.toggle=!1),l||(l=new e(this,a),n.data(f,l)),"string"==typeof t){if("undefined"==typeof l[t])throw new TypeError('No method named "'+t+'"');l[t]()}})},a(e,null,[{key:"VERSION",get:function(){return u}},{key:"Default",get:function(){return h}}]),e}();return r["default"](document).on(C,w,function(e){"A"===e.currentTarget.tagName&&e.preventDefault();var t=r["default"](this),n=s["default"].getSelectorFromElement(this),l=[].slice.call(document.querySelectorAll(n));r["default"](l).each(function(){var e=r["default"](this),n=e.data(f)?"toggle":t.data();D._jQueryInterface.call(e,n)})}),r["default"].fn[o]=D._jQueryInterface,r["default"].fn[o].Constructor=D,r["default"].fn[o].noConflict=function(){return r["default"].fn[o]=c,D._jQueryInterface},D});