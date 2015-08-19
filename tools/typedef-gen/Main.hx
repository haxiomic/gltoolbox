import sys.io.File;
import sys.FileSystem;

class Main{

	function new(){
		var outdir = 'output';

		if(FileSystem.exists(outdir)){
			FileSystem.deleteDirectory(outdir);
		}

		FileSystem.createDirectory(outdir);

		var names:Array<String>;
		var dir:String;
		//TypedArray
		names = [
			'ArrayBuffer',
			'ArrayBufferIO',
			'ArrayBufferView',
			'DataView',

			'Float32Array',
			'Float64Array',
			'Int16Array',
			'Int32Array',
			'Int8Array',
			'Uint16Array',
			'Uint32Array',
			'Uint8Array',
			'Uint8ClampedArray'
		];

		dir = '$outdir/typedarray';

		FileSystem.createDirectory(dir);

		for(name in names){
			var filename = '$name.hx';
			trace('saving $filename');
			File.saveContent(dir+'/'+filename, typedArrayModule(name, 'gltoolbox.typedarray'));
		}

		//GL
		names = [
			'GLActiveInfo',
			'GLBuffer',
			'GLContextAttributes',
			'GLFramebuffer',
			'GLProgram',
			'GLRenderbuffer',
			'GLShader',
			'GLTexture',
			'GLUniformLocation'
		];

		dir = '$outdir/gl';

		FileSystem.createDirectory(dir);

		for(name in names){
			var filename = '$name.hx';
			trace('saving $filename');
			File.saveContent(dir+'/'+filename, glModule(name, 'gltoolbox.gl'));
		}

		//special
		inline function copy(src:String, dst:String){
			// var srcPath = (new haxe.io.Path(src));
			trace('copying $src');
			File.copy(src, dst+'/'+haxe.io.Path.withoutDirectory(src));
		}

		copy('special/gl/GL.hx', '$outdir/gl/');
		copy('special/gl/GLShaderPrecisionFormat.hx', '$outdir/gl/');
	}


	function typedArrayModule(name:String, packageStr:String):String{
		return 'package $packageStr;

#if snow
typedef $name = snow.api.buffers.$name;
#elseif lime
typedef $name = lime.utils.$name;
#elseif nme
typedef $name = nme.utils.$name;
#elseif hxsdl
// ...
#elseif js
typedef $name = js.html.$name;
#else
typedef $name = haxe.io.$name;
#end
';
	}

	function glModule(name:String, packageStr:String):String{
		var nameWithoutPrefix = name.substr(2);

		var str = 'package $packageStr;

#if snow
typedef $name = snow.modules.opengl.GL.$name;
#elseif lime
typedef $name = lime.graphics.opengl.$name;
#elseif nme
typedef $name = nme.gl.$name;
#elseif hxsdl
typedef $name = sdl.GL.$nameWithoutPrefix;
#elseif js
typedef $name = js.html.webgl.$nameWithoutPrefix;
#else
typedef $name = Dynamic;
#end';
		
		return str;
	}

	static function main() new Main();
}