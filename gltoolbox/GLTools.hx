package gltoolbox;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.gl.GLTexture;

class GLTools{

	//Buffer Tools
	static private var bufferCache = new BufferCache();

	static public function createGLBuffer(vertices:Array<Float>, usage:Int = GL.STATIC_DRAW, allowCaching:Bool = false):GLBuffer{
		var buffer:GLBuffer;

		if(allowCaching){
			buffer = bufferCache.get(vertices, usage);
			if(buffer != null)
				return buffer;
		}

		var buffer = GL.createBuffer();
		GL.bindBuffer(GL.ARRAY_BUFFER, buffer);
		GL.bufferData(GL.ARRAY_BUFFER, new Float32Array(vertices), buffer);
		GL.bindBuffer(GL.ARRAY_BUFFER, null);

		if(allowCaching){
			bufferCache.set(vertices, usage, buffer);
		}

		return buffer;
	}

	//Texture Tools
	static public var defaultTextureParams:TextureParams = {
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
		for(f in Reflect.fields(defaultTextureParams))
			if(!Reflect.hasField(params, f))
				Reflect.setField(params, f, Reflect.field(defaultTextureParams, f));

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


/* BufferCache */
private typedef BufferKey = {
	vertices:Array<Float>;
	usage:Int;
};

private typedef BufferCacheItem = {
	var key:BufferKey;
	var buffer:GLBuffer;
}

class BufferCache{
	private var bufferCache:Array<BufferCacheItem>;

	public function new(){
		bufferCache = new Array<BufferCacheItem>();
	}

	public function clear(){
		bufferCache = new Array<BufferCacheItem>();
	}

	public inline function get(vertices:Array<Float>, usage:Int):GLBuffer{
		if(usage != GL.STATIC_DRAW){
			#if debug
			trace('only buffers with usage set to STATIC_DRAW can be cached');
			#end
			return null;
		}
		return getWithKey(getBufferKey(vertices, usage));
	}

	public inline function set(vertices:Array<Float>, usage:Int, buffer:GLBuffer){
		if(usage != GL.STATIC_DRAW){
			#if debug
			trace('only buffers with usage set to STATIC_DRAW can be cached');
			#end
			return null;
		}
		return setWithKey(getBufferKey(vertices, usage), buffer);
	}


	//private
	function getBufferKey(vertices:Array<Float>, usage:Int):BufferKey{
		return {
			vertices: vertices,
			usage: usage
		}
	}

	function getWithKey(key:BufferKey):GLBuffer{
		function areArraysEqual(a:Array<Float>, b:Array<Float>):Bool{
			if(a.length != b.length) return false;

			for(i in 0...a.length)
				if(a[i] != b[i]) return false;

			return true;
		}

		//brute force search
		for(bci in bufferCache){
			if(bci.key.usage != key.usage)
				break;

			if(!GL.isBuffer(bci.buffer))
				break;

			if(!areArraysEqual(key.vertices, bci.key.vertices))
				break;

			//return cached buffer
			return bci.buffer;
		}

		return null;
	}

	function setWithKey(key:BufferKey, buffer:GLBuffer){
		bufferCache.push({
			key: key,
			buffer: buffer
		});
	}
}