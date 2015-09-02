package nucleus.math;

import nucleus.typedarray.Float32Array;


//abstract gives automatic to-Float32Array but not from-Float32Array
//this prevents subsequent types being too flexible
abstract VectorDataType(Float32Array) to Float32Array{
	public inline function new(len:Int){
		this = new Float32Array(len);
	}
	
	inline function toFloat32Array():Float32Array return this;

	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;
}