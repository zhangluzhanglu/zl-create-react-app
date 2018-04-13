# zl-create-react-app
一个基于windows下bat脚本的react脚手架

<h4><span style="color: red;text-align:red;">脚手架构建流程如下：</span></h4>
<strong>1、 创建应用模板</strong>

和我们普通开发一样，创建index.html文件，创建几个目录如,css,js,img,script等，当然还要对目录细分一下，以便更合理。

<strong>2、 安装必备的工具</strong>

安装：node.js，webpack/browserify，babel，react相关地的依赖包等

<strong>3. 构建我们的项目</strong>

使用这些工具处理我们的代码，构建我们的项目。

主要做三件事：
1. es6/7,jsx等语法转义（babel）
2. Js代码打包为一个build.js文件(browserify/webpack)  
3. 对css打包拼接为一个build.css文件(拼接到一起就可以了，不需要安装其他模块)

<strong>4. 让我们的项目变得自动化</strong>

自动化含义为：当我们修改代码后，整个项目能够自动构建，执行上面三步，甚至是热更新到浏览器，而不需要我们自己去手动执行命令
<p style="text-align: center;"><span style="color: #800000;"><strong>3,4两步既可以安装watch模块监听代码状态来自动化，也可以通过安装Gulp或Grunt来自动化构建</strong></span></p>

<strong>5、压缩代码，优化图片</strong>

代码打包完成后，我们还应该进行代码压缩，图像优化等。
可以使用js压缩工具:uglify和css压缩工具cssshrink来处理，实现压缩代码，优化图片，复制文件到内容分发网络。
其实我们还可以做些代码混悉，以提高安全性等。

<strong>6. 发布</strong>

最后，我们将最终代码【一个index.html文件，一个css文件，一个js文件，一个静态资源文件夹（包含图片等）】复制到服务器上

<hr />

<strong>总结下流程：</strong>

创建模板应用---》安装目必备模块---》使用安装的模块自动构建项目--》代码压缩，图片优化------》上线发布

<p style="text-align: center;">           <strong>这些流程，rcreate-react-app等脚手架都帮我做好了，我们可以专注于代码的开发。</strong></p>


<hr />

<h1 style="text-align: center;"><span style="color: #ff0000;">脚手架构建流程实例如下</span></h1>
<h2>1、创建模板应用</h2>
和我们传统的web项目开发一样，主要是建立各种项目目录，如下：

&nbsp;
<pre>│ index.html   //html模版，所有组件都渲染到这里
│ package-lock.json //各个包版本信息的锁定文件
│ package.json  //各个包和项目信息
│ 
├─css 
│ │ app.css   //公用css代码，如：html{color:balck}
│ │ readme.txt
│ │ 
│ └─components //各个组件css代码
├─images //存放图片的地方
├─js
│ │ 
│ ├─build  // js代码经过转义打包后会生成到这里(这个目录最开始也可以不创建，在转义时，会自动生成的)
│ └─source 
│ │ ├─app.js //js入口文件，将组件渲染到html文件中 
│ │ ├─components
│ │   ├─demo.js //一个demo组件文件
├─scripts  //存放脚本文件的地方
│ installTools.bat //脚本文件
│ 
└─test //存放单元测试文件的地方

初步大致就这些，可以根据需要增删，比如添加sass/less文件夹等。</pre>

<hr />

<h2><strong>2、 安装必备的工具</strong></h2>
主要执行以下命令：
<pre>cnpm i browserify -g          //安装browserify，对react组件等进行打包（模块化解决方案之一，同webpack）
cnpm i babel-cli -g           //安装babel,对jsx，es6等进行转义
cnpm i babel-preset-react -D  //转义jsx
cnpm i babel-preset-es2015 -D //转义es6
cnpm i react -D               //react的核心库
cnpm i react-dom -D           //react中用于操作DOM的库

</pre>

<hr />

<h2>3、开始构建</h2>
主要有三件事：
<ol>
 	<li>转义js中的jsx语法和es6语法</li>
 	<li>打包转义后的所有js文件为一个js文件</li>
 	<li>将所有css文件拼接为一个css文件</li>
</ol>
<strong>1. 转义js中的jsx语法和es6语法 </strong>
<pre>   babel --presets react,es2015 js\source -d js\build</pre>
<strong>2. 打包转义后的所有js文件为一个js文件</strong>
<pre>   browserify js\build\app.js -o build.js</pre>
<strong>3.将所有css文件拼接为一个css文件</strong>
<pre>   type css\*.css css\components\*.css &gt; build.css

<strong>当js打包和css拼接后，图片路径可能会失效，需要处理下，解决方式如下:
</strong>
方式一：
当js打包和css拼接后，最终生成的js与css文件都是和index.html,image处于同一目录下，
所有我们可以在使用时，图片路径字符串就直接写出image开头，这样打包后就不会影响了。
如：
let demoIcoAddr="images/welcome.png";
&lt;img src={demoIcoAddr} /&gt;</pre>
方式二： 手动替换

<strong>注意：</strong>
<ol>
 	<li>在转义或者打包时，如果目标文件如果不存在会自动创建，如果存在就会覆盖。</li>
 	<li>在windows中的斜杠为反斜杠\，mac,linux下为正斜杠/</li>
 	<li>在js转义与打包，css拼接过程中，以当前命令窗口目录（一般为根目录）为基目录</li>
</ol>
&nbsp;

<hr />

<strong>4. 让我们的项目变得自动化</strong>

每次我们修改代码后都需要进行，js转义打包，css拼接，这些会比较麻烦，然后我们想办法让他自动化起来

如下：
<ol>
 	<li><strong>将这几条打包拼接命令放入到一个脚本文件[<span style="color: #800000;"><span style="color: #ff0000;">build.bat</span>]</span>中</strong>
<pre>
babel --presets react,es2015 js\source -d js\build //转义js文件
browserify js\build\app.js -o build.js //打包文件（将所有app.js文件依赖的js模块全部打包到一个文件中）
type css\*.css css\components\*.css &gt; build.css //拼接所有css文件为一个文件</pre>
</li>
 	<li><strong><strong>安装watch模块到本地，然后对js/css文件进行监听，一旦监听到js/css修改了，就执行打包拼接脚本build.bat</strong></strong>（注意：执行脚本时注意脚本文件路径应该正确，且mac是正斜杠/,window是反斜杠\,而且有可能还需要使用转义）
<pre>cnpm i watch -D  //安装watch</pre>
<pre>watch  "scripts\\<strong>build</strong>.bat" js/source css  //开启监听模式</pre>
</li>
 	<li><strong>同时我们也可以把我们的脚本文件执行命令放入到package.json文件中的scripts属性中，这样每次打开项目进行开发时，我们可以直接使用npm run build的方式初始化项目，让项目跑起来。</strong></li>
</ol>
<pre>      "build": "scripts\\<strong>build</strong>.bat"</pre>

<hr />

<strong>5.代码压缩，图像优化</strong>

上面的几步已经让我们的项目完成了，现在我们即将进行发布，不过发布前先要做些代码的压缩和图像的优化等工作

<b>待续...</b>


