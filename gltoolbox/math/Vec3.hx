package gltoolbox.math;

abstract Vec3(VectorData) from VectorData{

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;

	public inline function new(x:Float = 0, y:Float = 0, z:Float = 0){
		this = new VectorData(3);
		set(x, y, z);
	}

	public inline function set(x:Float, y:Float, z:Float):Vec3{
		set_x(x);
		set_y(y);
		set_z(z);
		return this;
	}

	public inline function setX(s:Float):Vec3{
		x = s;
		return this;
	}

	public inline function setY(s:Float):Vec3{
		y = s;
		return this;
	}

	public inline function setZ(s:Float):Vec3{
		z = s;
		return this;
	}

	public inline function setFn(fn:Int->Float):Vec3{
		x = fn(0);
		y = fn(1);
		z = fn(2);
		return this;
	}

	public inline function applyFn(fn:Vec3->Int->Void):Vec3{
		fn(this, 0);
		fn(this, 1);
		fn(this, 2);
		return this;
	}

	public inline function add(v:Vec3):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] += v[i]);
		return this;
	}

	public inline function addScalar(s:Float):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] += s);
		return this;
	}

	public inline function sub(v:Vec3):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] -= v[i]);
		return this;
	}

	public inline function subScalar(s:Float):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] -= s);
		return this;
	}

	public inline function multiply(v:Vec3):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] *= v[i]);
		return this;
	}

	public inline function multiplyScalar(s:Float):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] *= s);
		return this;
	}

	public inline function divide(v:Vec3):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] /= v[i]);
		return this;
	}

	public inline function divideScalar(s:Float):Vec3{
		var invS = 1/s;
		applyFn(function(t:Vec3, i:Int) t[i] *= invS);
		return this;
	}

	public inline function min(v:Vec3):Vec3{
		applyFn(function(t:Vec3, i:Int) if(t[i] > v[i]) t[i] = v[i] );
		return this;
	}

	public inline function max(v:Vec3):Vec3{
		applyFn(function(t:Vec3, i:Int) if(t[i] < v[i]) t[i] = v[i] );
		return this;
	}

	public inline function clamp(min:Vec3, max:Vec3):Vec3{
		applyFn(function(t:Vec3, i:Int){
			if(this[i] < min[i])
				this[i] = min[i];
			else if(this[i] > max[i])
				this[i] = max[i];
		});
		return this;
	}

	public inline function clampScalar(minVal:Float, maxVal:Float):Vec3{
		applyFn(function(t:Vec3, i:Int){
			if(this[i] < minVal)
				this[i] = minVal;
			else if(this[i] > maxVal)
				this[i] = maxVal;
		});
		return this;
	}

	public inline function floor( s:Float ):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] = Math.floor(t[i]) );
		return this;
	}

	public inline function ceil():Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] = Math.ceil(t[i]) );
		return this;
	}

	public inline function round():Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] = Math.round(t[i]) );
		return this;
	}

	public inline function dot(v:Vec3):Float{
		return x*v.x + y*v.y + z*v.z;
	}

	public inline function lengthSq():Float{
		return x*x + y*y + z*z;
	}

	public inline function length():Float{
		return Math.sqrt(lengthSq());
	}

	public inline function normalize():Vec3{
		return divideScalar(length());
	}

	public inline function setLength(l:Float):Vec3{
		var ol:Float = length();
		if(ol != 0){
			multiplyScalar(l / ol);
		}
		return this;
	}

	public inline function lerp(v:Vec3, alpha:Float):Vec3{
		applyFn(function(t:Vec3, i:Int) t[i] = t[i] + (v[i] - t[i])*alpha );
		return this;
	}

	public inline function cross(v:Vec3):Vec3{
		//t[i % 3] = _t[(i+1) % 3] * v[(i+2) % 3] - _t[(i+2) % 3] * v[(i+1) % 3];
		var _x = x; var _y = y; var _z = z;
		x = _y * v.z - _z * v.y;
		y = _z * v.x - _x * v.z;
		z = _x * v.y - _y * v.x;
		return this;
	}

	public inline function angleTo(v:Vec3):Float{
		var theta = dot(v) / (length() * v.length());
		var v = Math.acos(theta);
		//clamp v from -1 to 1
		if(v < -1) v = -1;
		if(v > 1) v = 1;
		return v;
	}

	public inline function distanceToSq(v:Vec3):Float{
		var dx = x - v.x;
		var dy = y - v.y;
		var dz = z - v.z;
		return dx*dx + dy*dy + dz*dz;
	}

	public inline function distanceTo( v:Vec3 ):Float{
		return Math.sqrt(distanceToSq(v));
	}

	public inline function equals( v:Vec3 ):Bool{
		return (x == v.x) && (y == v.y) && (z == v.z);
	}

	public inline function clone():Vec3{
		return new Vec3(x, y, z);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	//properties
	inline function get_x():Float return this[0];
	inline function get_y():Float return this[1];
	inline function get_z():Float return this[2];
	inline function set_x(v:Float):Float return this[0] = v;
	inline function set_y(v:Float):Float return this[1] = v;
	inline function set_z(v:Float):Float return this[2] = v;

	public inline function toString():String return 'Vec3($x, $y, $z)';
	
}