package nucleus.buffer;

import nucleus.gl.GLBuffer;
import nucleus.typedarray.ArrayBufferView;

//@! tmp
@:enum
abstract BufferUsage(Int) to Int from Int{
	var STREAM_DRAW = GL.STREAM_DRAW;
	var STATIC_DRAW = GL.STATIC_DRAW;
	var DYNAMIC_DRAW = GL.DYNAMIC_DRAW;
}

class Buffer{

	public var data:ArrayBufferView;

	//usage mode
	var usage:BufferUsage;

	//createBuffer():GLBuffer
	//deleteBuffer(buffer:GLBuffer):Void
	//isBuffer(buffer:GLBuffer):Bool

	// bufferData(target:Int, data:ArrayBufferView, usage:Int):Void
	// bufferSubData(target:Int, offset:Int, data:ArrayBufferView):Void
	// - buffer state
	// getBufferParameter(target:Int, pname:Int):Dynamic
	//	target:
	//		gl.ARRAY_BUFFER
	//		gl.ELEMENT_ARRAY_BUFFER
	//	pname:
	//		gl.BUFFER_SIZE
	//		gl.BUFFER_USAGE


	/* Unexplained

	ELEMENT_ARRAY_BUFFER_BINDING
	CURRENT_VERTEX_ATTRIB

	*/
	
	private var glBuffer:GLBuffer;

	public function new(data:ArrayBufferView, usage:BufferUsage = BufferUsage.STATIC_DRAW){
		this.data = data;
		this.usage = usage;
	}
	
	public function initialize():Buffer{
		glBuffer = GL.createBuffer();
		GL.bindBuffer(GL.ARRAY_BUFFER, glBuffer);
		GL.bufferData(GL.ARRAY_BUFFER, data, usage);
		return this;
	}

	public function dispose():Buffer{
		GL.deleteBuffer(glBuffer);
		return this;
	}


	static private inline function activate(){
		//@! track active buffer
	}

}