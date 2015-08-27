/*
	Mat4

	- values are set in (normal) column-major order, but stored in GL friendly row-major order
*/

package gltoolbox.math;

import gltoolbox.math.Orientation;
import gltoolbox.typedarray.Float32Array;

abstract Mat4(VectorDataType) from VectorDataType{

	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;

	public inline function new(
		n11:Float = 1, n12:Float = 0, n13:Float = 0, n14:Float = 0,
		n21:Float = 0, n22:Float = 1, n23:Float = 0, n24:Float = 0,
		n31:Float = 0, n32:Float = 0, n33:Float = 1, n34:Float = 0,
		n41:Float = 0, n42:Float = 0, n43:Float = 0, n44:Float = 1
	){
		this = new VectorDataType(16);
		set(
			n11, n12, n13, n14,
			n21, n22, n23, n24,
			n31, n32, n33, n34,
			n41, n42, n43, n44
		);
	}

	public function set(
		n11:Float, n12:Float, n13:Float, n14:Float,
		n21:Float, n22:Float, n23:Float, n24:Float,
		n31:Float, n32:Float, n33:Float, n34:Float,
		n41:Float, n42:Float, n43:Float, n44:Float
	):Mat4{
		this[0] = n11; this[4] = n12; this[8] = n13; this[12] = n14;
		this[1] = n21; this[5] = n22; this[9] = n23; this[13] = n24;
		this[2] = n31; this[6] = n32; this[10] = n33; this[14] = n34;
		this[3] = n41; this[7] = n42; this[11] = n43; this[15] = n44;
		return this;
	}

	public function setFromQuat(q:Quat):Mat4{
		var x2 = q.x + q.x, y2 = q.y + q.y, z2 = q.z + q.z;
		var xx = q.x * x2, xy = q.x * y2, xz = q.x * z2;
		var yy = q.y * y2, yz = q.y * z2, zz = q.z * z2;
		var wx = q.w * x2, wy = q.w * y2, wz = q.w * z2;
		set(
			1 - (yy + zz), xy - wz,       xz + wy,       0,
			xy + wz,       1 - (xx + zz), yz - wx,       0,
			xz - wy,       yz + wx,       1 - (xx + yy), 0,
			0,             0,             0,             1
		);
		return this;
	}

	public function setFromEuler(e:Euler):Mat4{
		var cx = Math.cos(e.swappedX); var sx = Math.sin(e.swappedX);
		var cy = Math.cos(e.swappedY); var sy = Math.sin(e.swappedY);
		var cz = Math.cos(e.swappedZ); var sz = Math.sin(e.swappedZ);
		set(
			 cy*cz,  cx*sz + sx*sy*cz, sx*sz - cx*sy*cz, 0,
			-cy*sz,  cx*cz - sx*sy*sz, sx*cz + cx*sy*sz, 0,
			 sy,    -sx*cy,            cx*cy,            0,
			 0,      0,                0,                1
		);
		return this;
	}

	public function setFromMat4(m:Mat4):Mat4{
		each(function(t:Mat4, idx:Int, _, _) this[idx] = m[idx] );
		return this;
	}

	public inline function getRowCol(row:Int, col:Int):Float{
		return this[(col - 1)*4 + (row - 1)];
	}

	public inline function setRowCol(row:Int, col:Int, v:Float):Float{
		return this[(col - 1)*4 + (row - 1)] = v;
	}

	public inline function each(fn:Mat4->Int->Int->Int->Void):Mat4{
		//(idx, row, col);
		//idx = (col - 1)*4 + (row - 1)
		fn(this, 0, 1, 1); fn(this, 4, 1, 2); fn(this, 8, 1, 3); fn(this, 12, 1, 4);
		fn(this, 1, 2, 1); fn(this, 5, 2, 2); fn(this, 9, 2, 3); fn(this, 13, 2, 4);
		fn(this, 2, 3, 1); fn(this, 6, 3, 2); fn(this, 10, 3, 3); fn(this, 14, 3, 4);
		fn(this, 3, 4, 1); fn(this, 7, 4, 2); fn(this, 11, 4, 3); fn(this, 15, 4, 4);
		return this;
	}

	public function identity():Mat4{
		each(function(t:Mat4, idx:Int, row:Int, col:Int) this[idx] = (col == row ? 1 : 0) );
		return this;
	}

	public function multiplyScalar(s:Float):Mat4{
		each(function(t:Mat4, idx:Int, row:Int, col:Int) this[idx] *= s );
		return this;
	}

	public inline function divideScalar(s:Float):Mat4{
		var invS = 1/s;
		multiplyScalar(invS);
		return this;
	}

	public inline function postmultiply(m:Mat4):Mat4{
		multiplyInto(this, this, m);
		return this;
	}

	public inline function premultiply(m:Mat4):Mat4{
		multiplyInto(this, m, this);
		return this;
	}

	public function determinant():Float{
		var n11 = this[0], n12 = this[4], n13 = this[8], n14 = this[12];
		var n21 = this[1], n22 = this[5], n23 = this[9], n24 = this[13];
		var n31 = this[2], n32 = this[6], n33 = this[10], n34 = this[14];
		var n41 = this[3], n42 = this[7], n43 = this[11], n44 = this[15];
		return (
			n41 * (
				   n14 * n23 * n32
				 - n13 * n24 * n32
				 - n14 * n22 * n33
				 + n12 * n24 * n33
				 + n13 * n22 * n34
				 - n12 * n23 * n34
			) +
			n42 * (
				   n11 * n23 * n34
				 - n11 * n24 * n33
				 + n14 * n21 * n33
				 - n13 * n21 * n34
				 + n13 * n24 * n31
				 - n14 * n23 * n31
			) +
			n43 * (
				   n11 * n24 * n32
				 - n11 * n22 * n34
				 - n14 * n21 * n32
				 + n12 * n21 * n34
				 + n14 * n22 * n31
				 - n12 * n24 * n31
			) +
			n44 * (
				 - n13 * n22 * n31
				 - n11 * n23 * n32
				 + n11 * n22 * n33
				 + n13 * n21 * n32
				 - n12 * n21 * n33
				 + n12 * n23 * n31
			)
		);
	}

	public function transpose():Mat4{
		var _t;
		_t = this[1]; this[1] = this[4]; this[4] = _t;
		_t = this[2]; this[2] = this[8]; this[8] = _t;
		_t = this[6]; this[6] = this[9]; this[9] = _t;

		_t = this[3]; this[3] = this[12]; this[12] = _t;
		_t = this[7]; this[7] = this[13]; this[13] = _t;
		_t = this[11]; this[11] = this[14]; this[14] = _t;
		return this;
	}

	/* Transformation matrix functions */
	public function scaleBy(?vec3:Vec3, scaleX:Float = 1, ?scaleY:Float, ?scaleZ:Float):Mat4{
		if(vec3 != null){
			scaleX = vec3.x;
			scaleY = vec3.y;
			scaleZ = vec3.z;
		}else{
			if(scaleY == null) scaleY = scaleX;
			if(scaleZ == null) scaleZ = scaleY;
		}

		this[0] *= scaleX; this[4] *= scaleY; this[8] *= scaleZ;
		this[1] *= scaleX; this[5] *= scaleY; this[9] *= scaleZ;
		this[2] *= scaleX; this[6] *= scaleY; this[10] *= scaleZ;
		this[3] *= scaleX; this[7] *= scaleY; this[11] *= scaleZ;
		return this;
	}

	public function compose(position:Vec3, rotation:Orientation, scale:Vec3):Mat4{
		/*
		if rotation didn't eliminate position, we could set components optionally:

		if(scale == null && rotation == null){
			//nothing more to do (assuming position has been set)
			return this;
		}else if(scale == null){
			//extract current scale
			scale = new Vec3();
			decompose(null, null, scale);
		}else if(rotation == null){
			//extract current rotation
			rotation = new Mat4();
			decompose(null, rotation, null);
		}
		*/

		//rotation
		switch rotation{
			case Quat(q):
				setFromQuat(q);
			case Euler(e):
				setFromEuler(e);
			case Mat4(m):
				setFromMat4(m);
		}

		//scale
		scaleBy(scale);

		//position
		x = position.x;
		y = position.y;
		z = position.z;

		return this;
	}

	public function decompose(?position:Vec3, ?rotation:Orientation, ?scale:Vec3):Mat4{
		inline function length(a:Float, b:Float, c:Float) return Math.sqrt(a*a + b*b + c*c);
		var sx = length(this[0], this[1], this[2]);
		var sy = length(this[4], this[5], this[6]);
		var sz = length(this[8], this[9], this[10]);

		var det = determinant();
		if(det < 0) sx = -sx;

		//position
		if(position != null){
			position.set(x,y,z);
		}

		//rotation
		if(rotation != null){		
			var mat4:Mat4 = new Mat4();
			mat4.setFromMat4(this);

			var invSX = 1/sx;
			var invSY = 1/sy;
			var invSZ = 1/sz;

			mat4[0] *= invSX; mat4[4] *= invSY; mat4[8] *= invSZ;
			mat4[1] *= invSX; mat4[5] *= invSY; mat4[9] *= invSZ;
			mat4[2] *= invSX; mat4[6] *= invSY; mat4[10] *= invSZ;

			rotation.setFromMat4(mat4);
		}

		//scale
		if(scale != null){
			scale.set(sx, sy, sz);
		}

		return this;
	}

	//properties
	private inline function get_x():Float return this[12];
	private inline function get_y():Float return this[13];
	private inline function get_z():Float return this[14];
	private inline function set_x(v:Float):Float return this[12] = v;
	private inline function set_y(v:Float):Float return this[13] = v;
	private inline function set_z(v:Float):Float return this[14] = v;

	/* ------------------------------- */

	public inline function clone():Mat4{
		return (new Mat4()).setFromMat4(this);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	@:to inline function toFloat32Array():Float32Array return this;

	public function toString():String{
		inline function transposedIdx(i:Int){
			return ((i % 4) * 4) + Math.floor(i/4);
		}

		var str = 'Mat4(\n    ';
		for(i in 0...this.length){
			str += this[transposedIdx(i)];
			if(i < this.length - 1){
				str += ' ';
				if(i % 4 == 3) str += '\n    ';
			}
		}
		str += '\n)';
		return str;
	}


	/* Mat4 static */

	static public function multiplyInto(into:Mat4, a:Mat4, b:Mat4):Mat4{
		var a11 = a[0], a12 = a[4], a13 = a[8], a14 = a[12];
		var a21 = a[1], a22 = a[5], a23 = a[9], a24 = a[13];
		var a31 = a[2], a32 = a[6], a33 = a[10], a34 = a[14];
		var a41 = a[3], a42 = a[7], a43 = a[11], a44 = a[15];

		var b11 = b[0], b12 = b[4], b13 = b[8], b14 = b[12];
		var b21 = b[1], b22 = b[5], b23 = b[9], b24 = b[13];
		var b31 = b[2], b32 = b[6], b33 = b[10], b34 = b[14];
		var b41 = b[3], b42 = b[7], b43 = b[11], b44 = b[15];

		into[0] = a11 * b11 + a12 * b21 + a13 * b31 + a14 * b41;
		into[4] = a11 * b12 + a12 * b22 + a13 * b32 + a14 * b42;
		into[8] = a11 * b13 + a12 * b23 + a13 * b33 + a14 * b43;
		into[12] = a11 * b14 + a12 * b24 + a13 * b34 + a14 * b44;

		into[1] = a21 * b11 + a22 * b21 + a23 * b31 + a24 * b41;
		into[5] = a21 * b12 + a22 * b22 + a23 * b32 + a24 * b42;
		into[9] = a21 * b13 + a22 * b23 + a23 * b33 + a24 * b43;
		into[13] = a21 * b14 + a22 * b24 + a23 * b34 + a24 * b44;

		into[2] = a31 * b11 + a32 * b21 + a33 * b31 + a34 * b41;
		into[6] = a31 * b12 + a32 * b22 + a33 * b32 + a34 * b42;
		into[10] = a31 * b13 + a32 * b23 + a33 * b33 + a34 * b43;
		into[14] = a31 * b14 + a32 * b24 + a33 * b34 + a34 * b44;

		into[3] = a41 * b11 + a42 * b21 + a43 * b31 + a44 * b41;
		into[7] = a41 * b12 + a42 * b22 + a43 * b32 + a44 * b42;
		into[11] = a41 * b13 + a42 * b23 + a43 * b33 + a44 * b43;
		into[15] = a41 * b14 + a42 * b24 + a43 * b34 + a44 * b44;

		return into;
	}

}