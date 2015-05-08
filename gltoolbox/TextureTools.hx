package gltoolbox;

#if snow
import snow.modules.opengl.GL;
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
			return createTexture(width, height, channelType, dataType, filter, unpackAlignment);
		}
	}

	static public inline function createFloatTextureRGB(
		width:Int,
		height:Int):GLTexture{
		return createTexture(width, height, GL.RGB, GL.FLOAT);
	}

	static public inline function createFloatTextureRGBA(
		width:Int,
		height:Int):GLTexture{
		return createTexture(width, height, GL.RGBA, GL.FLOAT);
	}

	static public inline function createTexture(
		width:Int,
		height:Int,
		channelType:Int     = GL.RGBA,
		dataType:Int        = GL.UNSIGNED_BYTE,
		filter:Int          = GL.NEAREST,
		unpackAlignment:Int = 4):GLTexture{

		#if ios //#! temporary test
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
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, GL.CLAMP_TO_EDGE);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, GL.CLAMP_TO_EDGE);

		GL.pixelStorei(GL.UNPACK_ALIGNMENT, 4); //see (see http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml)

		//set data
		GL.texImage2D(GL.TEXTURE_2D, 0, channelType, width, height, 0, channelType, dataType, null);

		//unbind
		GL.bindTexture(GL.TEXTURE_2D, null);

		return texture;
	}
}