package nucleus.math;

import nucleus.typedarray.Float32Array;

@:forward
abstract Quat(VectorDataType) from VectorDataType{

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;
	public var w(get, set):Float;

	public inline function new(x:Float = 0, ?y:Float, ?z:Float, w:Float = 1){
		this = new VectorDataType(4);
		if(y == null) y = x;
		if(z == null) z = y;
		set(x, y, z, w);
	}

	public inline function set(x:Float, y:Float, z:Float, w:Float):Quat{
		set_x(x);
		set_y(y);
		set_z(z);
		set_w(w);
		return this;
	}

	public inline function setX(s:Float):Quat{
		x = s;
		return this;
	}

	public inline function setY(s:Float):Quat{
		y = s;
		return this;
	}

	public inline function setZ(s:Float):Quat{
		z = s;
		return this;
	}

	public inline function setW(s:Float):Quat{
		w = s;
		return this;
	}

	public function setFromQuat(q:Quat):Quat{
		set(q.x, q.y, q.z, q.w);
		return this;
	}

	public function setFromEuler(e:Euler):Quat{
		var c1 = Math.cos(e.swappedX/2); var s1 = Math.sin(e.swappedX/2);
		var c2 = Math.cos(e.swappedY/2); var s2 = Math.sin(e.swappedY/2);
		var c3 = Math.cos(e.swappedZ/2); var s3 = Math.sin(e.swappedZ/2);
		set(
			s1 * c2 * c3 + c1 * s2 * s3,
			c1 * s2 * c3 - s1 * c2 * s3,
			c1 * c2 * s3 + s1 * s2 * c3,
			c1 * c2 * c3 - s1 * s2 * s3
		);
		return this;
	}

	public function setFromMat4(m:Mat4):Quat{
		throw 'not yet implemented';//@!
		return this;
	}

	public inline function each(fn:Quat->Int->Void):Quat{
		fn(this, 0);
		fn(this, 1);
		fn(this, 2);
		fn(this, 3);
		return this;
	}

	public inline function inverse():Quat{
		conjugate();
		normalize();
		return this;
	}

	public inline function conjugate():Quat{
		x *= -1;
		y *= -1;
		z *= -1;
		return this;
	}

	public inline function dot(v:Quat):Float{
		return x*v.x + y*v.y + z*v.z + w*v.w;
	}

	public inline function lengthSq():Float{
		return x*x + y*y + z*z + w*w;
	}

	public inline function length():Float{
		return Math.sqrt(lengthSq());
	}
	
	public function normalize():Quat{
		var l = length();

		if(l == 0){
			x = y = z = 0;
			w = 1;
		}else{
			l = 1/l;
			x *= l;
			y *= l;
			z *= l;
			w *= l;
		}

		return this;
	}

	public function multiply(q:Quat):Quat{
		//a = this
		var qax = x, qay = y, qaz = z, qaw = w;
		var qbx = q.x, qby = q.y, qbz = q.z, qbw = q.w;

		x = qax * qbw + qaw * qbx + qay * qbz - qaz * qby;
		y = qay * qbw + qaw * qby + qaz * qbx - qax * qbz;
		z = qaz * qbw + qaw * qbz + qax * qby - qay * qbx;
		w = qaw * qbw - qax * qbx - qay * qby - qaz * qbz;
		return this;
	}

	public function slerp(qFinal:Quat, t:Float):Quat{
		//@!
		throw 'slerp needs testing';

		if(t == 0) return this;
		if(t == 1) return setFromQuat(qFinal);

		var _x = x, _y = y, _z = z, _w = w;

		// http://www.euclideanspace.com/maths/algebra/realNormedAlgebra/quaternions/slerp/

		var cosHalfTheta = _w * qFinal.w + _x * qFinal.x + _y * qFinal.y + _z * qFinal.z;

		if(cosHalfTheta < 0) {
			w = -qFinal.w;
			x = -qFinal.x;
			y = -qFinal.y;
			z = -qFinal.z;
			cosHalfTheta = -cosHalfTheta;
		}else if (cosHalfTheta >= 1.0) {
			return this;
		}else{
			setFromQuat(qFinal);
		}

		var halfTheta = Math.acos(cosHalfTheta);
		var sinHalfTheta = Math.sqrt(1.0 - cosHalfTheta * cosHalfTheta);

		if(Math.abs(sinHalfTheta) < 0.001) {
			w = 0.5 * ( _w + w );
			x = 0.5 * ( _x + x );
			y = 0.5 * ( _y + y );
			z = 0.5 * ( _z + z );
			return this;
		}

		var ratioA = Math.sin(( 1 - t ) * halfTheta)/sinHalfTheta,
		ratioB = Math.sin(t * halfTheta)/sinHalfTheta;

		w = (_w * ratioA + w * ratioB);
		x = (_x * ratioA + x * ratioB);
		y = (_y * ratioA + y * ratioB);
		z = (_z * ratioA + z * ratioB);

		return this;
	}

	public inline function equals( v:Quat ):Bool{
		return (x == v.x) && (y == v.y) && (z == v.z) && (w == v.w);
	}

	public inline function clone():Quat{
		return new Quat(x, y, z, w);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;


	//properties
	private inline function get_x():Float return this[0];
	private inline function get_y():Float return this[1];
	private inline function get_z():Float return this[2];
	private inline function get_w():Float return this[3];
	private inline function set_x(v:Float):Float return this[0] = v;
	private inline function set_y(v:Float):Float return this[1] = v;
	private inline function set_z(v:Float):Float return this[2] = v;
	private inline function set_w(v:Float):Float return this[3] = v;
	
	public inline function toString():String return 'Quat($x, $y, $z, $w)';
	
}