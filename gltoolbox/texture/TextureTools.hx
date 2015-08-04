package gltoolbox.texture;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLTexture;

class TextureTools{

	static public var defaultParams:TextureParams = {
		channelType     : GL.RGBA,
		dataType        : GL.UNSIGNED_BYTE,
		filter          : GL.NEAREST,
		wrapS           : GL.CLAMP_TO_EDGE,
		wrapT           : GL.CLAMP_TO_EDGE,
		unpackAlignment : 4
	};

	static public function createGLTexture(width:Int, height:Int, ?params:TextureParams):GLTexture{
		if(params == null) params = {};

		//extend default params
		for(f in Reflect.fields(defaultParams))
			if(!Reflect.hasField(params, f))
				Reflect.setField(params, f, Reflect.field(defaultParams, f));

		#if ios //@! temporary test
		if(dataType == GL.FLOAT){
			// trace('GL.FLOAT is not supported, changing to half float');
			dataType = 0x8D61;//GL_HALF_FLOAT_OES
		}
		#end

		var texture:GLTexture = GL.createTexture();
		GL.bindTexture (GL.TEXTURE_2D, texture);

		//set params
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MIN_FILTER, params.filter); 
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_MAG_FILTER, params.filter); 
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_S, params.wrapS);
		GL.texParameteri(GL.TEXTURE_2D, GL.TEXTURE_WRAP_T, params.wrapT);

		GL.pixelStorei(GL.UNPACK_ALIGNMENT, params.unpackAlignment); //see http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml

		//set data
		GL.texImage2D(GL.TEXTURE_2D, 0, params.channelType, width, height, 0, params.channelType, params.dataType, null);

		//unbind
		GL.bindTexture(GL.TEXTURE_2D, null);

		return texture;
	}

	static public inline function createGLTextureFactory(?params:TextureParams):GLTextureFactory{
		return function (width:Int, height:Int){
			return createGLTexture(width, height, params);
		}
	}

	static public inline function createGLTextureFloatRGB(width:Int, height:Int):GLTexture{
		return createGLTexture(width, height, {
			channelType: GL.RGB,
			dataType: GL.FLOAT
		});
	}

	static public inline function createGLTextureFloatRGBA(width:Int, height:Int):GLTexture{
		return createGLTexture(width, height, {
			channelType: GL.RGBA,
			dataType: GL.FLOAT
		});
	}
	
}