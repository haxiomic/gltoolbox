package gltoolbox.core;

import gltoolbox.gl.GLBuffer;
import gltoolbox.math.Vec2;
import gltoolbox.math.Vec3;
import gltoolbox.math.Vec4;
import gltoolbox.typedarray.Float32Array;


enum Attribute{
	FloatAttribute(f:Float);
	FloatArrayAttribute(fa:Float32Array);
	FVec2Attribute(v:Vec2);
	FVec2ArrayAttribute(va:Array<Vec2>);
	FVec3Attribute(v:Vec3);
	FVec3ArrayAttribute(va:Array<Vec3>);
	FVec4Attribute(v:Vec4);
	FVec4ArrayAttribute(va:Array<Vec4>);
	BufferAttribute<T>(b:BufferAttributeData<T>);
}

typedef BufferAttributeData<T> = {
	var data:T;
	var itemSize:Int;
	var buffer:GLBuffer;
}