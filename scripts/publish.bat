RD /S /Q __publish 
md __publish 
uglifyjs build.js -o -m __publish/build.js 
cssshrink build.css > __publish/build.css 
copy index.html __publish/index.html 
copy images/ __publish/images 
