package gltoolbox.math;

abstract Mat4(VectorData) from VectorData{

	public inline function new(){
		this = new VectorData(16);
		identity();
	}

	public inline function set(
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

	public inline function each(fn:Mat4->Int->Int->Int->Void):Mat4{
		//(idx, row, col);
		//idx = (col - 1)*3 + (row - 1)
		fn(this, 0, 1, 1); fn(this, 4, 1, 2); fn(this, 8, 1, 3);  fn(this, 12, 1, 4);
		fn(this, 1, 2, 1); fn(this, 5, 2, 2); fn(this, 9, 2, 3);  fn(this, 13, 2, 4);
		fn(this, 2, 3, 1); fn(this, 6, 3, 2);  fn(this, 10, 3, 3);  fn(this, 14, 3, 4);
		fn(this, 3, 4, 1); fn(this, 7, 4, 2);  fn(this, 11, 4, 3);  fn(this, 15, 4, 4);
		return this;
	}

	public function identity():Mat4{
		each(function(t:Mat4, idx:Int, i:Int, j:Int) this[idx] = (i == j ? 1 : 0) );
		return this;
	}

	public function multiplyScalar(s:Float):Mat4{
		each(function(t:Mat4, idx:Int, i:Int, j:Int) this[idx] *= s );
		return this;
	}

	public inline function deviceScalar(s:Float):Mat4{
		var invS = 1/s;
		multiplyScalar(invS);
		return this;
	}

	public function determinant():Float{
		var n11 = this[0], n12 = this[4], n13 = this[8], n14 = this[12],
		    n21 = this[1], n22 = this[5], n23 = this[9], n24 = this[13],
		    n31 = this[2], n32 = this[6], n33 = this[10], n34 = this[14],
		    n41 = this[3], n42 = this[7], n43 = this[11], n44 = this[15];
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

	// public function clone():Mat4{
	// }

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	public function toString():String{
		var str = 'Mat4(\n    ';
		for(i in 0...this.length){
			str += this[i];
			if(i < this.length - 1){
				str += ' ';
				if(i % 4 == 3) str += '\n    ';
			}
		}
		str += '\n)';
		return str;
	}
	
}