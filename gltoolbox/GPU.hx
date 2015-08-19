/*
	GPU

	Utility functions for common GL operations

	@! notes
	- should be a thin (essentially) standalone interface over GL
	- no compound types here
	- do we really need buffer cache?
*/

package gltoolbox;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.gl.GLTexture;
import gltoolbox.gl.GLProgram;
import gltoolbox.typedarray.Float32Array;
import gltoolbox.typedarray.ArrayBufferView;


class GPU{

	//Shader Tools
	static public function uploadShaders(geometryShaderSrc:String, pixelShaderSrc:String):GLProgram{
		var geometryShader = GL.createShader(GL.VERTEX_SHADER);
		GL.shaderSource(geometryShader, geometryShaderSrc);
		GL.compileShader(geometryShader);

		//check for compilation errors
		if(GL.getShaderParameter(geometryShader, GL.COMPILE_STATUS) == 0){
			throw 'Geometry shader error: '+GL.getShaderInfoLog(geometryShader);
		}

		var pixelShader = GL.createShader(GL.FRAGMENT_SHADER);
		GL.shaderSource(pixelShader, pixelShaderSrc);
		GL.compileShader(pixelShader);

		//check for compilation errors
		if(GL.getShaderParameter(pixelShader, GL.COMPILE_STATUS) == 0){
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
	static public function uploadArray(typedArray:ArrayBufferView, usage:Int = GL.STATIC_DRAW, allowCaching:Bool = false):GLBuffer{
		var buffer:GLBuffer;

		var buffer = GL.createBuffer();
		GL.bindBuffer(GL.ARRAY_BUFFER, buffer);
		GL.bufferData(GL.ARRAY_BUFFER, typedArray, usage);
		GL.bindBuffer(GL.ARRAY_BUFFER, null);

		return buffer;
	}

	//Texture Tools
	static public function allocateTexture(
		width:Int,
		height:Int,
		channelType:Int = GL.RGBA,
		dataType:Int = GL.UNSIGNED_BYTE,
		filter:Int = GL.NEAREST,
		wrapS:Int = GL.CLAMP_TO_EDGE,
		wrapT:Int = GL.CLAMP_TO_EDGE,
		unpackAlignment:Int = 4
	):GLTexture{

		#if ios //@! temporary test
		if(dataType == GL.FLOAT){
			// trace('GL.FLOAT is not supported, changing to half float');
			dataType = 0x8D61;//GL_HALF_FLOAT_OES
		}
		#end

		var texture:GLTexture = GL.createTexture();
		GL.bindTexture (GL.TEXTURE_2D, texture);

		//set params
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, filter); 
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, filter); 
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, wrapS);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, wrapT);

		GL.pixelStorei(GL.UNPACK_ALIGNMENT, unpackAlignment); //see http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml

		//set data
		GL.texImage2D(GL.TEXTURE_2D, 0, channelType, width, height, 0, channelType, dataType, null);

		//unbind
		GL.bindTexture(GL.TEXTURE_2D, null);

		return texture;
	}

}