package gltoolbox.buffer;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;

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