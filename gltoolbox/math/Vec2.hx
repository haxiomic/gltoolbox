package gltoolbox.math;

abstract Vec2(VectorDataType) from VectorDataType{

	public var x(get, set):Float;
	public var y(get, set):Float;

	public inline function new(x:Float = 0, ?y:Float){
		this = new VectorDataType(2);
		if(y == null) y = x;
		set(x, y);
	}

	public inline function set(x:Float, y:Float):Vec2{
		set_x(x);
		set_y(y);
		return this;
	}

	public inline function setX(s:Float):Vec2{
		x = s;
		return this;
	}

	public inline function setY(s:Float):Vec2{
		y = s;
		return this;
	}

	public inline function each(fn:Vec2->Int->Void):Vec2{
		fn(this, 0);
		fn(this, 1);
		return this;
	}

	public inline function add(v:Vec2):Vec2{
		each(function(t:Vec2, i:Int) this[i] += v[i]);
		return this;
	}

	public inline function addScalar(s:Float):Vec2{
		each(function(t:Vec2, i:Int) this[i] += s);
		return this;
	}

	public inline function sub(v:Vec2):Vec2{
		each(function(t:Vec2, i:Int) this[i] -= v[i]);
		return this;
	}

	public inline function subScalar(s:Float):Vec2{
		each(function(t:Vec2, i:Int) this[i] -= s);
		return this;
	}

	public inline function multiply(v:Vec2):Vec2{
		each(function(t:Vec2, i:Int) this[i] *= v[i]);
		return this;
	}

	public inline function multiplyScalar(s:Float):Vec2{
		each(function(t:Vec2, i:Int) this[i] *= s);
		return this;
	}

	public inline function divide(v:Vec2):Vec2{
		each(function(t:Vec2, i:Int) this[i] /= v[i]);
		return this;
	}

	public inline function divideScalar(s:Float):Vec2{
		var invS = 1/s;
		each(function(t:Vec2, i:Int) this[i] *= invS);
		return this;
	}

	public inline function min(v:Vec2):Vec2{
		each(function(t:Vec2, i:Int) if(this[i] > v[i]) this[i] = v[i] );
		return this;
	}

	public inline function max(v:Vec2):Vec2{
		each(function(t:Vec2, i:Int) if(this[i] < v[i]) this[i] = v[i] );
		return this;
	}

	public inline function clamp(min:Vec2, max:Vec2):Vec2{
		each(function(t:Vec2, i:Int){
			if(this[i] < min[i])
				this[i] = min[i];
			else if(this[i] > max[i])
				this[i] = max[i];
		});
		return this;
	}

	public inline function clampScalar(minVal:Float, maxVal:Float):Vec2{
		each(function(t:Vec2, i:Int){
			if(this[i] < minVal)
				this[i] = minVal;
			else if(this[i] > maxVal)
				this[i] = maxVal;
		});
		return this;
	}

	public inline function floor( s:Float ):Vec2{
		each(function(t:Vec2, i:Int) this[i] = Math.floor(this[i]) );
		return this;
	}

	public inline function ceil():Vec2{
		each(function(t:Vec2, i:Int) this[i] = Math.ceil(this[i]) );
		return this;
	}

	public inline function round():Vec2{
		each(function(t:Vec2, i:Int) this[i] = Math.round(this[i]) );
		return this;
	}

	public inline function dot(v:Vec2):Float{
		return x*v.x + y*v.y;
	}

	public inline function lengthSq():Float{
		return x*x + y*y;
	}

	public inline function length():Float{
		return Math.sqrt(lengthSq());
	}

	public inline function normalize():Vec2{
		return divideScalar(length());
	}

	public inline function setLength(l:Float):Vec2{
		var ol:Float = length();
		if(ol != 0){
			multiplyScalar(l / ol);
		}
		return this;
	}

	public inline function lerp(v:Vec2, alpha:Float):Vec2{
		each(function(t:Vec2, i:Int) this[i] = this[i] + (v[i] - this[i])*alpha );
		return this;
	}

	public inline function distanceToSq(v:Vec2):Float{
		var dx = x - v.x;
		var dy = y - v.y;
		return dx*dx + dy*dy;
	}

	public inline function distanceTo( v:Vec2 ):Float{
		return Math.sqrt(distanceToSq(v));
	}

	public inline function equals( v:Vec2 ):Bool{
		return (x == v.x) && (y == v.y);
	}

	public inline function clone():Vec2{
		return new Vec2(x, y);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	//properties
	inline function get_x():Float return this[0];
	inline function get_y():Float return this[1];
	inline function set_x(v:Float):Float return this[0] = v;
	inline function set_y(v:Float):Float return this[1] = v;

	public inline function toString():String return 'Vec2($x, $y)';
	
}