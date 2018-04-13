babel --presets react,es2015 js\source -d js\build && browserify js\build\app.js -o build.js && type css\*.css css\components\*.css > build.css      
