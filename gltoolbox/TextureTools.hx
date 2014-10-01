package gltoolbox;

#if snow
import snow.render.opengl.GL;
#elseif lime
import lime.graphics.opengl.GL;
import lime.graphics.opengl.GLTexture;
#end

class TextureTools{
	static public inline function createTextureFactory(
		?channelType:Int     = GL.RGBA,
		?dataType:Int        = GL.UNSIGNED_BYTE,
		?filter:Int          = GL.NEAREST,
		?unpackAlignment:Int = 4):Int->Int->GLTexture{
		return function (width:Int, height:Int){
			return textureFactory(width, height, channelType, dataType, filter, unpackAlignment);
		}
	}

	static public inline function floatTextureFactoryRGB(
		width:Int,
		height:Int):GLTexture{
		return textureFactory(width, height, GL.RGB, GL.FLOAT);
	}

	static public inline function floatTextureFactoryRGBA(
		width:Int,
		height:Int):GLTexture{
		return textureFactory(width, height, GL.RGBA, GL.FLOAT);
	}

	static public inline function textureFactory(
		width:Int,
		height:Int,
		channelType:Int     = GL.RGBA,
		dataType:Int        = GL.UNSIGNED_BYTE,
		filter:Int          = GL.NEAREST,
		unpackAlignment:Int = 4):GLTexture{

		var texture:GLTexture = GL.createTexture();
		GL.bindTexture (GL.TEXTURE_2D, texture);

		//set params
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, filter); 
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, filter); 
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);

		GL.pixelStorei(GL.UNPACK_ALIGNMENT, 4); //see (see http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml)

		//set data
		GL.texImage2D (GL.TEXTURE_2D, 0, channelType, width, height, 0, channelType, dataType, null);

		//unbind
		GL.bindTexture(GL.TEXTURE_2D, null);
		return texture;
	}
}