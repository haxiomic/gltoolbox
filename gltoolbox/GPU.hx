/*
	GPU

	Utility functions for common GL operations

	@! todo
	texture functions

*/

package gltoolbox;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.gl.GLTexture;
import gltoolbox.gl.GLProgram;
import gltoolbox.typedarray.Float32Array;
import gltoolbox.typedarray.ArrayBufferView;


class GPU{

	static public var MAX_VERTEX_ATTRIBS(get, null):Null<Int>;
	static public var MAX_VARYING_VECTORS(get, null):Null<Int>;
	static public var MAX_VERTEX_UNIFORM_VECTORS(get, null):Null<Int>;
	static public var MAX_FRAGMENT_UNIFORM_VECTORS(get, null):Null<Int>;
	static public var MAX_TEXTURE_IMAGE_UNITS(get, null):Null<Int>;
	static public var MAX_VERTEX_TEXTURE_IMAGE_UNITS(get, null):Null<Int>;
	static public var MAX_COMBINED_TEXTURE_IMAGE_UNITS(get, null):Null<Int>;
	static public var MAX_TEXTURE_SIZE(get, null):Null<Int>;
	static public var MAX_CUBE_MAP_TEXTURE_SIZE(get, null):Null<Int>;
	static public var MAX_RENDERBUFFER_SIZE(get, null):Null<Int>;

	//Shader Tools
	static public function compileShaders(geometryShaderSrc:String, pixelShaderSrc:String):GLProgram{
		var geometryShader = GL.createShader(GL.VERTEX_SHADER);
		GL.shaderSource(geometryShader, geometryShaderSrc);
		GL.compileShader(geometryShader);

		//check for compilation errors
		if(GL.getShaderParameter(geometryShader, GL.COMPILE_STATUS) == 0){
			GL.deleteShader(geometryShader);
			throw 'Geometry shader error: '+GL.getShaderInfoLog(geometryShader);
		}

		var pixelShader = GL.createShader(GL.FRAGMENT_SHADER);
		GL.shaderSource(pixelShader, pixelShaderSrc);
		GL.compileShader(pixelShader);

		//check for compilation errors
		if(GL.getShaderParameter(pixelShader, GL.COMPILE_STATUS) == 0){
			GL.deleteShader(pixelShader);
			throw 'Pixel shader error: '+GL.getShaderInfoLog(pixelShader);
		}

		var program = GL.createProgram();
		GL.attachShader(program, geometryShader);
		GL.attachShader(program, pixelShader);
		GL.linkProgram(program);

		if(GL.getProgramParameter(program, GL.LINK_STATUS) == 0){
			GL.detachShader(program, geometryShader);
			GL.detachShader(program, pixelShader);
			GL.deleteShader(geometryShader);
			GL.deleteShader(pixelShader);
			throw GL.getProgramInfoLog(program);
		}

		return program;
	}

	//Buffer Tools
	static public function uploadArray(?buffer:GLBuffer, typedArray:ArrayBufferView, usage:Int = GL.STATIC_DRAW):GLBuffer{
		if(buffer == null)
			buffer = GL.createBuffer();
		
		GL.bindBuffer(GL.ARRAY_BUFFER, buffer);
		GL.bufferData(GL.ARRAY_BUFFER, typedArray, usage);

		return buffer;
	}

	//properties
	//cache important properties
	static private function get_MAX_VERTEX_ATTRIBS():Null<Int>{
		if(MAX_VERTEX_ATTRIBS == null)
			MAX_VERTEX_ATTRIBS = GL.getParameter(GL.MAX_VERTEX_ATTRIBS);
		return MAX_VERTEX_ATTRIBS;
	}

	static private function get_MAX_VARYING_VECTORS():Null<Int>{
		if(MAX_VARYING_VECTORS == null)
			MAX_VARYING_VECTORS = GL.getParameter(GL.MAX_VARYING_VECTORS);
		return MAX_VARYING_VECTORS;
	}

	static private function get_MAX_VERTEX_UNIFORM_VECTORS():Null<Int>{
		if(MAX_VERTEX_UNIFORM_VECTORS == null)
			MAX_VERTEX_UNIFORM_VECTORS = GL.getParameter(GL.MAX_VERTEX_UNIFORM_VECTORS);
		return MAX_VERTEX_UNIFORM_VECTORS;
	}

	static private function get_MAX_FRAGMENT_UNIFORM_VECTORS():Null<Int>{
		if(MAX_FRAGMENT_UNIFORM_VECTORS == null)
			MAX_FRAGMENT_UNIFORM_VECTORS = GL.getParameter(GL.MAX_FRAGMENT_UNIFORM_VECTORS);
		return MAX_FRAGMENT_UNIFORM_VECTORS;
	}

	static private function get_MAX_TEXTURE_IMAGE_UNITS():Null<Int>{
		if(MAX_TEXTURE_IMAGE_UNITS == null)
			MAX_TEXTURE_IMAGE_UNITS = GL.getParameter(GL.MAX_TEXTURE_IMAGE_UNITS);
		return MAX_TEXTURE_IMAGE_UNITS;
	}

	static private function get_MAX_VERTEX_TEXTURE_IMAGE_UNITS():Null<Int>{
		if(MAX_VERTEX_TEXTURE_IMAGE_UNITS == null)
			MAX_VERTEX_TEXTURE_IMAGE_UNITS = GL.getParameter(GL.MAX_VERTEX_TEXTURE_IMAGE_UNITS);
		return MAX_VERTEX_TEXTURE_IMAGE_UNITS;
	}

	static private function get_MAX_COMBINED_TEXTURE_IMAGE_UNITS():Null<Int>{
		if(MAX_COMBINED_TEXTURE_IMAGE_UNITS == null)
			MAX_COMBINED_TEXTURE_IMAGE_UNITS = GL.getParameter(GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS);
		return MAX_COMBINED_TEXTURE_IMAGE_UNITS;
	}

	static private function get_MAX_TEXTURE_SIZE():Null<Int>{
		if(MAX_TEXTURE_SIZE == null)
			MAX_TEXTURE_SIZE = GL.getParameter(GL.MAX_TEXTURE_SIZE);
		return MAX_TEXTURE_SIZE;
	}

	static private function get_MAX_CUBE_MAP_TEXTURE_SIZE():Null<Int>{
		if(MAX_CUBE_MAP_TEXTURE_SIZE == null)
			MAX_CUBE_MAP_TEXTURE_SIZE = GL.getParameter(GL.MAX_CUBE_MAP_TEXTURE_SIZE);
		return MAX_CUBE_MAP_TEXTURE_SIZE;
	}

	static private function get_MAX_RENDERBUFFER_SIZE():Null<Int>{
		if(MAX_RENDERBUFFER_SIZE == null)
			MAX_RENDERBUFFER_SIZE = GL.getParameter(GL.MAX_RENDERBUFFER_SIZE);
		return MAX_RENDERBUFFER_SIZE;
	}


}