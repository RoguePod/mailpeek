/**
 * Minified by jsDelivr using Terser v3.14.1.
 * Original file: /npm/rails-ujs@5.2.3/lib/assets/compiled/rails-ujs.js
 *
 * Do NOT use SRI with dynamically generated files! More information: https://www.jsdelivr.com/using-sri-with-dynamic-files
 */
(function(){(function(){(function(){this.Rails={linkClickSelector:"a[data-confirm], a[data-method], a[data-remote]:not([disabled]), a[data-disable-with], a[data-disable]",buttonClickSelector:{selector:"button[data-remote]:not([form]), button[data-confirm]:not([form])",exclude:"form button"},inputChangeSelector:"select[data-remote], input[data-remote], textarea[data-remote]",formSubmitSelector:"form",formInputClickSelector:"form input[type=submit], form input[type=image], form button[type=submit], form button:not([type]), input[type=submit][form], input[type=image][form], button[type=submit][form], button[form]:not([type])",formDisableSelector:"input[data-disable-with]:enabled, button[data-disable-with]:enabled, textarea[data-disable-with]:enabled, input[data-disable]:enabled, button[data-disable]:enabled, textarea[data-disable]:enabled",formEnableSelector:"input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled, input[data-disable]:disabled, button[data-disable]:disabled, textarea[data-disable]:disabled",fileInputSelector:"input[name][type=file]:not([disabled])",linkDisableSelector:"a[data-disable-with], a[data-disable]",buttonDisableSelector:"button[data-remote][data-disable-with], button[data-remote][data-disable]"}}).call(this)}).call(this);var t=this.Rails;(function(){(function(){var e;e=null,t.loadCSPNonce=function(){var t;return e=null!=(t=document.querySelector("meta[name=csp-nonce]"))?t.content:void 0},t.cspNonce=function(){return null!=e?e:t.loadCSPNonce()}}).call(this),function(){var e;e=Element.prototype.matches||Element.prototype.matchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector||Element.prototype.oMatchesSelector||Element.prototype.webkitMatchesSelector,t.matches=function(t,n){return null!=n.exclude?e.call(t,n.selector)&&!e.call(t,n.exclude):e.call(t,n)},t.getData=function(t,e){var n;return null!=(n=t._ujsData)?n[e]:void 0},t.setData=function(t,e,n){return null==t._ujsData&&(t._ujsData={}),t._ujsData[e]=n},t.$=function(t){return Array.prototype.slice.call(document.querySelectorAll(t))}}.call(this),function(){var e,n,a;e=t.$,a=t.csrfToken=function(){var t;return(t=document.querySelector("meta[name=csrf-token]"))&&t.content},n=t.csrfParam=function(){var t;return(t=document.querySelector("meta[name=csrf-param]"))&&t.content},t.CSRFProtection=function(t){var e;if(null!=(e=a()))return t.setRequestHeader("X-CSRF-Token",e)},t.refreshCSRFTokens=function(){var t,o;if(o=a(),t=n(),null!=o&&null!=t)return e('form input[name="'+t+'"]').forEach(function(t){return t.value=o})}}.call(this),function(){var e,n,a,o;a=t.matches,"function"!=typeof(e=window.CustomEvent)&&((e=function(t,e){var n;return(n=document.createEvent("CustomEvent")).initCustomEvent(t,e.bubbles,e.cancelable,e.detail),n}).prototype=window.Event.prototype,o=e.prototype.preventDefault,e.prototype.preventDefault=function(){var t;return t=o.call(this),this.cancelable&&!this.defaultPrevented&&Object.defineProperty(this,"defaultPrevented",{get:function(){return!0}}),t}),n=t.fire=function(t,n,a){var o;return o=new e(n,{bubbles:!0,cancelable:!0,detail:a}),t.dispatchEvent(o),!o.defaultPrevented},t.stopEverything=function(t){return n(t.target,"ujs:everythingStopped"),t.preventDefault(),t.stopPropagation(),t.stopImmediatePropagation()},t.delegate=function(t,e,n,o){return t.addEventListener(n,function(t){var n;for(n=t.target;n instanceof Element&&!a(n,e);)n=n.parentNode;if(n instanceof Element&&!1===o.call(n,t))return t.preventDefault(),t.stopPropagation()})}}.call(this),function(){var e,n,a,o,r,i;o=t.cspNonce,n=t.CSRFProtection,t.fire,e={"*":"*/*",text:"text/plain",html:"text/html",xml:"application/xml, text/xml",json:"application/json, text/javascript",script:"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"},t.ajax=function(t){var e;return t=r(t),e=a(t,function(){var n,a;return a=i(null!=(n=e.response)?n:e.responseText,e.getResponseHeader("Content-Type")),2===Math.floor(e.status/100)?"function"==typeof t.success&&t.success(a,e.statusText,e):"function"==typeof t.error&&t.error(a,e.statusText,e),"function"==typeof t.complete?t.complete(e,e.statusText):void 0}),!(null!=t.beforeSend&&!t.beforeSend(e,t))&&(e.readyState===XMLHttpRequest.OPENED?e.send(t.data):void 0)},r=function(t){return t.url=t.url||location.href,t.type=t.type.toUpperCase(),"GET"===t.type&&t.data&&(t.url.indexOf("?")<0?t.url+="?"+t.data:t.url+="&"+t.data),null==e[t.dataType]&&(t.dataType="*"),t.accept=e[t.dataType],"*"!==t.dataType&&(t.accept+=", */*; q=0.01"),t},a=function(t,e){var a;return(a=new XMLHttpRequest).open(t.type,t.url,!0),a.setRequestHeader("Accept",t.accept),"string"==typeof t.data&&a.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8"),t.crossDomain||a.setRequestHeader("X-Requested-With","XMLHttpRequest"),n(a),a.withCredentials=!!t.withCredentials,a.onreadystatechange=function(){if(a.readyState===XMLHttpRequest.DONE)return e(a)},a},i=function(t,e){var n,a;if("string"==typeof t&&"string"==typeof e)if(e.match(/\bjson\b/))try{t=JSON.parse(t)}catch(t){}else if(e.match(/\b(?:java|ecma)script\b/))(a=document.createElement("script")).setAttribute("nonce",o()),a.text=t,document.head.appendChild(a).parentNode.removeChild(a);else if(e.match(/\b(xml|html|svg)\b/)){n=new DOMParser,e=e.replace(/;.+/,"");try{t=n.parseFromString(t,e)}catch(t){}}return t},t.href=function(t){return t.href},t.isCrossDomain=function(t){var e,n;(e=document.createElement("a")).href=location.href,n=document.createElement("a");try{return n.href=t,!((!n.protocol||":"===n.protocol)&&!n.host||e.protocol+"//"+e.host==n.protocol+"//"+n.host)}catch(t){return t,!0}}}.call(this),function(){var e,n;e=t.matches,n=function(t){return Array.prototype.slice.call(t)},t.serializeElement=function(t,a){var o,r;return o=[t],e(t,"form")&&(o=n(t.elements)),r=[],o.forEach(function(t){if(t.name&&!t.disabled)return e(t,"select")?n(t.options).forEach(function(e){if(e.selected)return r.push({name:t.name,value:e.value})}):t.checked||-1===["radio","checkbox","submit"].indexOf(t.type)?r.push({name:t.name,value:t.value}):void 0}),a&&r.push(a),r.map(function(t){return null!=t.name?encodeURIComponent(t.name)+"="+encodeURIComponent(t.value):t}).join("&")},t.formElements=function(t,a){return e(t,"form")?n(t.elements).filter(function(t){return e(t,a)}):n(t.querySelectorAll(a))}}.call(this),function(){var e,n,a;n=t.fire,a=t.stopEverything,t.handleConfirm=function(t){if(!e(this))return a(t)},e=function(t){var e,a,o;if(!(o=t.getAttribute("data-confirm")))return!0;if(e=!1,n(t,"confirm")){try{e=confirm(o)}catch(t){}a=n(t,"confirm:complete",[e])}return e&&a}}.call(this),function(){var e,n,a,o,r,i,l,u,c,s,d;c=t.matches,u=t.getData,s=t.setData,d=t.stopEverything,l=t.formElements,t.handleDisabledElement=function(t){if(this,this.disabled)return d(t)},t.enableElement=function(e){var n;return n=e instanceof Event?e.target:e,c(n,t.linkDisableSelector)?i(n):c(n,t.buttonDisableSelector)||c(n,t.formEnableSelector)?o(n):c(n,t.formSubmitSelector)?r(n):void 0},t.disableElement=function(o){var r;return r=o instanceof Event?o.target:o,c(r,t.linkDisableSelector)?a(r):c(r,t.buttonDisableSelector)||c(r,t.formDisableSelector)?e(r):c(r,t.formSubmitSelector)?n(r):void 0},a=function(t){var e;return null!=(e=t.getAttribute("data-disable-with"))&&(s(t,"ujs:enable-with",t.innerHTML),t.innerHTML=e),t.addEventListener("click",d),s(t,"ujs:disabled",!0)},i=function(t){var e;return null!=(e=u(t,"ujs:enable-with"))&&(t.innerHTML=e,s(t,"ujs:enable-with",null)),t.removeEventListener("click",d),s(t,"ujs:disabled",null)},n=function(n){return l(n,t.formDisableSelector).forEach(e)},e=function(t){var e;return null!=(e=t.getAttribute("data-disable-with"))&&(c(t,"button")?(s(t,"ujs:enable-with",t.innerHTML),t.innerHTML=e):(s(t,"ujs:enable-with",t.value),t.value=e)),t.disabled=!0,s(t,"ujs:disabled",!0)},r=function(e){return l(e,t.formEnableSelector).forEach(o)},o=function(t){var e;return null!=(e=u(t,"ujs:enable-with"))&&(c(t,"button")?t.innerHTML=e:t.value=e,s(t,"ujs:enable-with",null)),t.disabled=!1,s(t,"ujs:disabled",null)}}.call(this),function(){var e;e=t.stopEverything,t.handleMethod=function(n){var a,o,r,i,l,u;if(this,u=this.getAttribute("data-method"))return l=t.href(this),o=t.csrfToken(),a=t.csrfParam(),r=document.createElement("form"),i="<input name='_method' value='"+u+"' type='hidden' />",null==a||null==o||t.isCrossDomain(l)||(i+="<input name='"+a+"' value='"+o+"' type='hidden' />"),i+='<input type="submit" />',r.method="post",r.action=l,r.target=this.target,r.innerHTML=i,r.style.display="none",document.body.appendChild(r),r.querySelector('[type="submit"]').click(),e(n)}}.call(this),function(){var e,n,a,o,r,i,l,u,c,s=[].slice;i=t.matches,a=t.getData,u=t.setData,n=t.fire,c=t.stopEverything,e=t.ajax,o=t.isCrossDomain,l=t.serializeElement,r=function(t){var e;return null!=(e=t.getAttribute("data-remote"))&&"false"!==e},t.handleRemote=function(d){var m,f,p,b,h,v,S;return!r(b=this)||(n(b,"ajax:before")?(S=b.getAttribute("data-with-credentials"),p=b.getAttribute("data-type")||"script",i(b,t.formSubmitSelector)?(m=a(b,"ujs:submit-button"),h=a(b,"ujs:submit-button-formmethod")||b.method,v=a(b,"ujs:submit-button-formaction")||b.getAttribute("action")||location.href,"GET"===h.toUpperCase()&&(v=v.replace(/\?.*$/,"")),"multipart/form-data"===b.enctype?(f=new FormData(b),null!=m&&f.append(m.name,m.value)):f=l(b,m),u(b,"ujs:submit-button",null),u(b,"ujs:submit-button-formmethod",null),u(b,"ujs:submit-button-formaction",null)):i(b,t.buttonClickSelector)||i(b,t.inputChangeSelector)?(h=b.getAttribute("data-method"),v=b.getAttribute("data-url"),f=l(b,b.getAttribute("data-params"))):(h=b.getAttribute("data-method"),v=t.href(b),f=b.getAttribute("data-params")),e({type:h||"GET",url:v,data:f,dataType:p,beforeSend:function(t,e){return n(b,"ajax:beforeSend",[t,e])?n(b,"ajax:send",[t]):(n(b,"ajax:stopped"),!1)},success:function(){var t;return t=1<=arguments.length?s.call(arguments,0):[],n(b,"ajax:success",t)},error:function(){var t;return t=1<=arguments.length?s.call(arguments,0):[],n(b,"ajax:error",t)},complete:function(){var t;return t=1<=arguments.length?s.call(arguments,0):[],n(b,"ajax:complete",t)},crossDomain:o(v),withCredentials:null!=S&&"false"!==S}),c(d)):(n(b,"ajax:stopped"),!1))},t.formSubmitButtonClick=function(t){var e;if(this,e=this.form)return this.name&&u(e,"ujs:submit-button",{name:this.name,value:this.value}),u(e,"ujs:formnovalidate-button",this.formNoValidate),u(e,"ujs:submit-button-formaction",this.getAttribute("formaction")),u(e,"ujs:submit-button-formmethod",this.getAttribute("formmethod"))},t.preventInsignificantClick=function(t){var e,n,a;if(this,a=(this.getAttribute("data-method")||"GET").toUpperCase(),e=this.getAttribute("data-params"),n=(t.metaKey||t.ctrlKey)&&"GET"===a&&!e,!(0===t.button)||n)return t.stopImmediatePropagation()}}.call(this),function(){var e,n,a,o,r,i,l,u,c,s,d,m,f,p,b;if(i=t.fire,a=t.delegate,u=t.getData,e=t.$,b=t.refreshCSRFTokens,n=t.CSRFProtection,f=t.loadCSPNonce,r=t.enableElement,o=t.disableElement,s=t.handleDisabledElement,c=t.handleConfirm,p=t.preventInsignificantClick,m=t.handleRemote,l=t.formSubmitButtonClick,d=t.handleMethod,"undefined"!=typeof jQuery&&null!==jQuery&&null!=jQuery.ajax){if(jQuery.rails)throw new Error("If you load both jquery_ujs and rails-ujs, use rails-ujs only.");jQuery.rails=t,jQuery.ajaxPrefilter(function(t,e,a){if(!t.crossDomain)return n(a)})}t.start=function(){if(window._rails_loaded)throw new Error("rails-ujs has already been loaded!");return window.addEventListener("pageshow",function(){return e(t.formEnableSelector).forEach(function(t){if(u(t,"ujs:disabled"))return r(t)}),e(t.linkDisableSelector).forEach(function(t){if(u(t,"ujs:disabled"))return r(t)})}),a(document,t.linkDisableSelector,"ajax:complete",r),a(document,t.linkDisableSelector,"ajax:stopped",r),a(document,t.buttonDisableSelector,"ajax:complete",r),a(document,t.buttonDisableSelector,"ajax:stopped",r),a(document,t.linkClickSelector,"click",p),a(document,t.linkClickSelector,"click",s),a(document,t.linkClickSelector,"click",c),a(document,t.linkClickSelector,"click",o),a(document,t.linkClickSelector,"click",m),a(document,t.linkClickSelector,"click",d),a(document,t.buttonClickSelector,"click",p),a(document,t.buttonClickSelector,"click",s),a(document,t.buttonClickSelector,"click",c),a(document,t.buttonClickSelector,"click",o),a(document,t.buttonClickSelector,"click",m),a(document,t.inputChangeSelector,"change",s),a(document,t.inputChangeSelector,"change",c),a(document,t.inputChangeSelector,"change",m),a(document,t.formSubmitSelector,"submit",s),a(document,t.formSubmitSelector,"submit",c),a(document,t.formSubmitSelector,"submit",m),a(document,t.formSubmitSelector,"submit",function(t){return setTimeout(function(){return o(t)},13)}),a(document,t.formSubmitSelector,"ajax:send",o),a(document,t.formSubmitSelector,"ajax:complete",r),a(document,t.formInputClickSelector,"click",p),a(document,t.formInputClickSelector,"click",s),a(document,t.formInputClickSelector,"click",c),a(document,t.formInputClickSelector,"click",l),document.addEventListener("DOMContentLoaded",b),document.addEventListener("DOMContentLoaded",f),window._rails_loaded=!0},window.Rails===t&&i(document,"rails:attachBindings")&&t.start()}.call(this)}).call(this),"object"==typeof module&&module.exports?module.exports=t:"function"==typeof define&&define.amd&&define(t)}).call(this);
