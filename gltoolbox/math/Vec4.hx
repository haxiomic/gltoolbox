package gltoolbox.math;

import gltoolbox.typedarray.Float32Array;

abstract Vec4(VectorDataType) from VectorDataType{
	
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var w(get, set):Float;

	public inline function new(x:Float = 0, ?y:Float, ?z:Float, ?w:Float){
		this = new VectorDataType(4);
		if(y == null) y = x;
		if(z == null) z = y;
		if(w == null) w = z;
		set(x, y, z, w);
	}

	public function set(x:Float, y:Float, z:Float, w:Float):Vec4{
		set_x(x);
		set_y(y);
		set_z(z);
		set_w(w);
		return this;
	}

	public inline function setX(s:Float):Vec4{
		x = s;
		return this;
	}

	public inline function setY(s:Float):Vec4{
		y = s;
		return this;
	}

	public inline function setZ(s:Float):Vec4{
		z = s;
		return this;
	}

	public inline function setW(s:Float):Vec4{
		w = s;
		return this;
	}

	public function setFromVec4(v:Vec4):Vec4{
		set(v.x, v.y, v.z, v.w);
		return this;
	}

	public inline function each(fn:Vec4->Int->Void):Vec4{
		fn(this, 0);
		fn(this, 1);
		fn(this, 2);
		fn(this, 3);
		return this;
	}

	public inline function add(v:Vec4):Vec4{
		each(function(t:Vec4, i:Int) this[i] += v[i]);
		return this;
	}

	public inline function addScalar(s:Float):Vec4{
		each(function(t:Vec4, i:Int) this[i] += s);
		return this;
	}

	public inline function sub(v:Vec4):Vec4{
		each(function(t:Vec4, i:Int) this[i] -= v[i]);
		return this;
	}

	public inline function subScalar(s:Float):Vec4{
		each(function(t:Vec4, i:Int) this[i] -= s);
		return this;
	}

	public inline function multiply(v:Vec4):Vec4{
		each(function(t:Vec4, i:Int) this[i] *= v[i]);
		return this;
	}

	public inline function multiplyScalar(s:Float):Vec4{
		each(function(t:Vec4, i:Int) this[i] *= s);
		return this;
	}

	public inline function divide(v:Vec4):Vec4{
		each(function(t:Vec4, i:Int) this[i] /= v[i]);
		return this;
	}

	public inline function divideScalar(s:Float):Vec4{
		if(s != 0){
			var invS = 1/s;
			each(function(t:Vec4, i:Int) this[i] *= invS);
		}else{
			x = 0;
			y = 0;
			z = 0;
			w = 1;
		}

		return this;
	}

	public inline function min(v:Vec4):Vec4{
		each(function(t:Vec4, i:Int) if(this[i] > v[i]) this[i] = v[i] );
		return this;
	}

	public inline function max(v:Vec4):Vec4{
		each(function(t:Vec4, i:Int) if(this[i] < v[i]) this[i] = v[i] );
		return this;
	}

	public inline function clamp(min:Vec4, max:Vec4):Vec4{
		each(function(t:Vec4, i:Int){
			if(this[i] < min[i])
				this[i] = min[i];
			else if(this[i] > max[i])
				this[i] = max[i];
		});
		return this;
	}

	public inline function clampScalar(minVal:Float, maxVal:Float):Vec4{
		each(function(t:Vec4, i:Int){
			if(this[i] < minVal)
				this[i] = minVal;
			else if(this[i] > maxVal)
				this[i] = maxVal;
		});
		return this;
	}

	public inline function floor( s:Float ):Vec4{
		each(function(t:Vec4, i:Int) this[i] = Math.floor(this[i]) );
		return this;
	}

	public inline function ceil():Vec4{
		each(function(t:Vec4, i:Int) this[i] = Math.ceil(this[i]) );
		return this;
	}

	public inline function round():Vec4{
		each(function(t:Vec4, i:Int) this[i] = Math.round(this[i]) );
		return this;
	}

	public inline function dot(v:Vec4):Float{
		return x*v.x + y*v.y + z*v.z + w*v.w;
	}

	public inline function lengthSq():Float{
		return x*x + y*y + z*z + w*w;
	}

	public inline function length():Float{
		return Math.sqrt(lengthSq());
	}

	public inline function normalize():Vec4{
		return divideScalar(length());
	}

	public inline function setLength(l:Float):Vec4{
		var ol:Float = length();
		if(ol != 0){
			multiplyScalar(l / ol);
		}
		return this;
	}

	public inline function lerp(v:Vec4, alpha:Float):Vec4{
		each(function(t:Vec4, i:Int) this[i] = this[i] + (v[i] - this[i])*alpha );
		return this;
	}

	public inline function equals( v:Vec4 ):Bool{
		return (x == v.x) && (y == v.y) && (z == v.z) && (w == v.w);
	}

	public inline function clone():Vec4{
		return new Vec4(x, y, z, w);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	@:to inline function toFloat32Array():Float32Array return this;

	//properties
	private inline function get_x():Float return this[0];
	private inline function get_y():Float return this[1];
	private inline function get_z():Float return this[2];
	private inline function get_w():Float return this[3];
	private inline function set_x(v:Float):Float return this[0] = v;
	private inline function set_y(v:Float):Float return this[1] = v;
	private inline function set_z(v:Float):Float return this[2] = v;
	private inline function set_w(v:Float):Float return this[3] = v;

	public inline function toString():String return 'Vec4($x, $y, $z, $w)';

}