package gltoolbox.math;

import gltoolbox.typedarray.Float32Array;

@:forward
abstract Euler(EulerClass) from EulerClass{

	public inline function new(?rotationX:Float, ?rotationY:Float, ?rotationZ:Float, ?order:Order){
		this = new EulerClass(rotationX, rotationY, rotationZ, order);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this.v[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this.v[i] = v;

	@:to inline function toFloat32Array():Float32Array return this.v;

	@:from static inline function fromArrayFloat(a:Array<Float>):Euler{
		return new Euler(a[0], a[1], a[2]);
	}
	
}

@:forward
@:enum
abstract Order(String) to String{
	var XYZ = 'XYZ';
	var YZX = 'YZX';
	var ZXY = 'ZXY';
	var XZY = 'XZY';
	var YXZ = 'YXZ';
	var ZYX = 'ZYX';
}

private class EulerClass{

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;

	public var swappedX(get, set):Float;
	public var swappedY(get, set):Float;
	public var swappedZ(get, set):Float;

	public var order:Order;

	public var v:Vec3;

	public function new(?rotationX:Float, ?rotationY:Float, ?rotationZ:Float, order:Order = XYZ){
		this.v = new Vec3(rotationX, rotationY, rotationZ);
		
		//@!
		if(order != XYZ){
			throw 'orders other than XYZ have yet to be tested';
			//@! search through code for uses of Euler
		}

		this.order = order;
	}

	public inline function set(rotationX:Float, rotationY:Float, rotationZ:Float, order:Order):EulerClass{
		this.x = rotationX;
		this.y = rotationY;
		this.z = rotationZ;
		this.order = order;

		if(order != XYZ){
			throw 'orders other than XYZ have yet to be tested';
			//@! search through code for uses of Euler
		}

		return this;
	}

	public function setFromQuat(q:Quat):EulerClass{
		trace('not yet implemented');
		return this;
	}

	public function setFromEuler(e:Euler):EulerClass{
		set(e.x, e.y, e.z, e.order);
		return this;
	}

	public function setFromMat4(m:Mat4):EulerClass{
		trace('not yet implemented');
		return this;
	}

	public inline function clone():EulerClass{
		return new EulerClass(x, y, z, order);
	}

	//@! needs review
	private inline function swappedIdx(i:Int) return order.charCodeAt(i) - 'X'.code;

	private inline function get_x():Float return this.v[0];
	private inline function get_y():Float return this.v[1];
	private inline function get_z():Float return this.v[2];
	private inline function set_x(v:Float):Float return this.v[0] = v;
	private inline function set_y(v:Float):Float return this.v[1] = v;
	private inline function set_z(v:Float):Float return this.v[2] = v;

	private inline function get_swappedX():Float return this.v[swappedIdx(0)];
	private inline function get_swappedY():Float return this.v[swappedIdx(1)];
	private inline function get_swappedZ():Float return this.v[swappedIdx(2)];
	private inline function set_swappedX(v:Float):Float return this.v[swappedIdx(0)] = v;
	private inline function set_swappedY(v:Float):Float return this.v[swappedIdx(1)] = v;
	private inline function set_swappedZ(v:Float):Float return this.v[swappedIdx(2)] = v;

}