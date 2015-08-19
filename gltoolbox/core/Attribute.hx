package gltoolbox.core;

import gltoolbox.gl.GLBuffer;
import gltoolbox.math.Vec2;
import gltoolbox.math.Vec3;
import gltoolbox.math.Vec4;
import gltoolbox.typedarray.Float32Array;
import gltoolbox.typedarray.ArrayBufferView;

enum Attribute{
	FloatAttribute(f:Float);
	FloatArrayAttribute(fa:Float32Array);
	FVec2Attribute(v:Vec2);
	FVec2ArrayAttribute(va:Array<Vec2>);
	FVec3Attribute(v:Vec3);
	FVec3ArrayAttribute(va:Array<Vec3>);
	FVec4Attribute(v:Vec4);
	FVec4ArrayAttribute(va:Array<Vec4>);
	BufferAttribute<T:ArrayBufferView>(b:BufferAttributeData<T>);
}

private typedef TBufferAttributeData<T:ArrayBufferView> = {
	var data:T;
	var itemSize:Int;
	var usage:Int;
	var buffer:GLBuffer;
}

@:forward
abstract BufferAttributeData<T:ArrayBufferView>(TBufferAttributeData<T>) from TBufferAttributeData<T>{
	public inline function gpuUpload():BufferAttributeData<T>{
		//@! needs support for dynamic data, replace with gpuSync?
		this.buffer = GPU.uploadArray(this.data, this.usage);
		return this;
	}
}