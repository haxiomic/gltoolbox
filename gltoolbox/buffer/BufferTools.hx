package gltoolbox.buffer;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.typedarray.Float32Array;

class BufferTools{

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
	
}