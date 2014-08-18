package gltoolbox;

import lime.graphics.opengl.GL;
import lime.graphics.GLRenderContext;
import lime.graphics.opengl.GLTexture;

class TextureTools{
	static public inline function FloatTextureFactoryRGB(
		gl:GLRenderContext,
		width:Int,
		height:Int):GLTexture{
		return textureFactory(gl, width, height, gl.RGB, gl.FLOAT);
	}

	static public inline function FloatTextureFactoryRGBA(
		gl:GLRenderContext,
		width:Int,
		height:Int):GLTexture{
		return textureFactory(gl, width, height, gl.RGBA, gl.FLOAT);
	}

	static public inline function textureFactory(
		gl:GLRenderContext,
		width:Int,
		height:Int,
		channelType:Int     = GL.RGBA,
		dataType:Int        = GL.UNSIGNED_BYTE,
		filter:Int          = GL.NEAREST,
		unpackAlignment:Int = 4):GLTexture{

		var texture:GLTexture = gl.createTexture();
		gl.bindTexture (gl.TEXTURE_2D, texture);

		//set params
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, filter); 
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, filter); 
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
		gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);

		gl.pixelStorei(gl.UNPACK_ALIGNMENT, 4); //see (see http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml)

		//set data
		gl.texImage2D (gl.TEXTURE_2D, 0, channelType, width, height, 0, channelType, dataType, null);

		//unbind
		gl.bindTexture(gl.TEXTURE_2D, null);
		return texture;
	}
}