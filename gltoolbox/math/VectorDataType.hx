package gltoolbox.math;

import gltoolbox.typedarray.Float32Array;

// typedef VectorDataType = Float32Array;

@:forward
abstract VectorDataType(Float32Array) from Float32Array to Float32Array{
	public inline function new(len:Int){
		this = new Float32Array(len);
	}

	@:from static inline function fromArrayFloat(a:Array<Float>):VectorDataType{
		return new Float32Array(a);
	}

	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;
}