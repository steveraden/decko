//script: html5shiv printshiv
!function(e,t){function n(e,t){var n=e.createElement("p"),r=e.getElementsByTagName("head")[0]||e.documentElement;return n.innerHTML="x<style>"+t+"</style>",r.insertBefore(n.lastChild,r.firstChild)}function r(){var e=T.elements;return"string"==typeof e?e.split(" "):e}function a(e){var t=N[e[b]];return t||(t={},S++,e[b]=S,N[S]=t),t}function o(e,n,r){if(n||(n=t),p)return n.createElement(e);r||(r=a(n));var o;return o=r.cache[e]?r.cache[e].cloneNode():E.test(e)?(r.cache[e]=r.createElem(e)).cloneNode():r.createElem(e),o.canHaveChildren&&!y.test(e)?r.frag.appendChild(o):o}function i(e,n){if(e||(e=t),p)return e.createDocumentFragment();n=n||a(e);for(var o=n.frag.cloneNode(),i=0,c=r(),l=c.length;l>i;i++)o.createElement(c[i]);return o}function c(e,t){t.cache||(t.cache={},t.createElem=e.createElement,t.createFrag=e.createDocumentFragment,t.frag=t.createFrag()),e.createElement=function(n){return T.shivMethods?o(n,e,t):t.createElem(n)},e.createDocumentFragment=Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+r().join().replace(/\w+/g,function(e){return t.createElem(e),t.frag.createElement(e),'c("'+e+'")'})+");return n}")(T,t.frag)}function l(e){e||(e=t);var r=a(e);return!T.shivCSS||h||r.hasCSS||(r.hasCSS=!!n(e,"article,aside,dialog,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}mark{background:#FF0;color:#000}template{display:none}")),p||c(e,r),e}function u(e){for(var t,n=e.getElementsByTagName("*"),a=n.length,o=RegExp("^(?:"+r().join("|")+")$","i"),i=[];a--;)t=n[a],o.test(t.nodeName)&&i.push(t.applyElement(s(t)));return i}function s(e){for(var t,n=e.attributes,r=n.length,a=e.ownerDocument.createElement(x+":"+e.nodeName);r--;)t=n[r],t.specified&&a.setAttribute(t.nodeName,t.nodeValue);return a.style.cssText=e.style.cssText,a}function m(e){for(var t,n=e.split("{"),a=n.length,o=RegExp("(^|[\\s,>+~])("+r().join("|")+")(?=[[\\s,>+~#.:]|$)","gi"),i="$1"+x+"\\:$2";a--;)t=n[a]=n[a].split("}"),t[t.length-1]=t[t.length-1].replace(o,i),n[a]=t.join("}");return n.join("{")}function d(e){for(var t=e.length;t--;)e[t].removeNode()}function f(e){function t(){clearTimeout(i._removeSheetTimer),r&&r.removeNode(!0),r=null}var r,o,i=a(e),c=e.namespaces,l=e.parentWindow;return!C||e.printShived?e:("undefined"==typeof c[x]&&c.add(x),l.attachEvent("onbeforeprint",function(){t();for(var a,i,c,l=e.styleSheets,s=[],d=l.length,f=Array(d);d--;)f[d]=l[d];for(;c=f.pop();)if(!c.disabled&&F.test(c.media)){try{a=c.imports,i=a.length}catch(e){i=0}for(d=0;i>d;d++)f.push(a[d]);try{s.push(c.cssText)}catch(e){}}s=m(s.reverse().join("")),o=u(e),r=n(e,s)}),l.attachEvent("onafterprint",function(){d(o),clearTimeout(i._removeSheetTimer),i._removeSheetTimer=setTimeout(t,500)}),e.printShived=!0,e)}var h,p,v="3.6.2",g=e.html5||{},y=/^<|^(?:button|map|select|textarea|object|iframe|option|optgroup)$/i,E=/^(?:a|b|code|div|fieldset|h1|h2|h3|h4|h5|h6|i|label|li|ol|p|q|span|strong|style|table|tbody|td|th|tr|ul)$/i,b="_html5shiv",S=0,N={};!function(){try{var e=t.createElement("a");e.innerHTML="<xyz></xyz>",h="hidden"in e,p=1==e.childNodes.length||function(){t.createElement("a");var e=t.createDocumentFragment();return"undefined"==typeof e.cloneNode||"undefined"==typeof e.createDocumentFragment||"undefined"==typeof e.createElement}()}catch(e){h=!0,p=!0}}();var T={elements:g.elements||"abbr article aside audio bdi canvas data datalist details dialog figcaption figure footer header hgroup main mark meter nav output progress section summary template time video",version:v,shivCSS:!1!==g.shivCSS,supportsUnknownElements:p,shivMethods:!1!==g.shivMethods,type:"default",shivDocument:l,createElement:o,createDocumentFragment:i};e.html5=T,l(t);var F=/^$|\b(?:all|print)\b/,x="html5shiv",C=!p&&function(){var n=t.documentElement;return!("undefined"==typeof t.namespaces||"undefined"==typeof t.parentWindow||"undefined"==typeof n.applyElement||"undefined"==typeof n.removeNode||"undefined"==typeof e.attachEvent)}();T.type+=" print",T.shivPrint=f,f(t)}(this,document);