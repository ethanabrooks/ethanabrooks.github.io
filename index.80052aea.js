!function(){var t,e,n,r={};function i(){throw Error("setTimeout has not been defined")}function o(){throw Error("clearTimeout has not been defined")}function u(e){if(t===setTimeout)return setTimeout(e,0);if((t===i||!t)&&setTimeout)return t=setTimeout,setTimeout(e,0);try{return t(e,0)}catch(n){try{return t.call(null,e,0)}catch(n){return t.call(this,e,0)}}}!function(){try{t="function"==typeof setTimeout?setTimeout:i}catch(e){t=i}try{e="function"==typeof clearTimeout?clearTimeout:o}catch(t){e=o}}();var c=[],s=!1,l=-1;function a(){s&&n&&(s=!1,n.length?c=n.concat(c):l=-1,c.length&&f())}function f(){if(!s){var t=u(a);s=!0;for(var r=c.length;r;){for(n=c,c=[];++l<r;)n&&n[l].run();l=-1,r=c.length}n=null,s=!1,function(t){if(e===clearTimeout)return clearTimeout(t);if((e===o||!e)&&clearTimeout)return e=clearTimeout,clearTimeout(t);try{e(t)}catch(n){try{return e.call(null,t)}catch(n){return e.call(this,t)}}}(t)}}function h(t,e){this.fun=t,this.array=e}function m(){}r.nextTick=function(t){var e=Array(arguments.length-1);if(arguments.length>1)for(var n=1;n<arguments.length;n++)e[n-1]=arguments[n];c.push(new h(t,e)),1!==c.length||s||u(f)},h.prototype.run=function(){this.fun.apply(null,this.array)},r.title="browser",r.browser=!0,r.env={},r.argv=[],r.version="",r.versions={},r.on=m,r.addListener=m,r.once=m,r.off=m,r.removeListener=m,r.removeAllListeners=m,r.emit=m,r.prependListener=m,r.prependOnceListener=m,r.listeners=function(t){return[]},r.binding=function(t){throw Error("process.binding is not supported")},r.cwd=function(){return"/"},r.chdir=function(t){throw Error("process.chdir is not supported")},r.umask=function(){return 0}}();
//# sourceMappingURL=index.80052aea.js.map