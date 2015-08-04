package gltoolbox.math;

abstract Mat3(VectorData) from VectorData{

	public inline function new(){
		this = new VectorData(9);
		identity();
	}

	public inline function set(
		n11:Float, n12:Float, n13:Float,
		n21:Float, n22:Float, n23:Float,
		n31:Float, n32:Float, n33:Float
	):Mat3{
		this[0] = n11; this[3] = n12; this[6] = n13;
		this[1] = n21; this[4] = n22; this[7] = n23;
		this[2] = n31; this[5] = n32; this[8] = n33;
		return this;
	}

	public inline function setFn(fn:Int->Int->Int->Float):Mat3{
		//(r, c);
		//i = (c - 1)*3 + (r - 1)
		this[0] = fn(0, 1, 1); this[3] = fn(3, 1, 2); this[6] = fn(6, 1, 3);
		this[1] = fn(1, 2, 1); this[4] = fn(4, 2, 2); this[7] = fn(7, 2, 3);
		this[2] = fn(2, 3, 1); this[5] = fn(5, 3, 2); this[8] = fn(8, 3, 3);
		return this;
	}

	public inline function applyFn(fn:Mat3->Int->Int->Int->Void):Mat3{
		fn(this, 0, 1, 1); fn(this, 3, 1, 2); fn(this, 6, 1, 3);
		fn(this, 1, 2, 1); fn(this, 4, 2, 2); fn(this, 7, 2, 3);
		fn(this, 2, 3, 1); fn(this, 5, 3, 2); fn(this, 8, 3, 3);
		return this;
	}

	public function identity():Mat3{
		applyFn(function(t:Mat3, idx:Int, i:Int, j:Int) t[idx] = (i == j ? 1 : 0) );
		return this;
	}

	public function multiplyScalar(s:Float):Mat3{
		applyFn(function(t:Mat3, idx:Int, i:Int, j:Int) t[idx] *= s );
		return this;
	}

	public inline function deviceScalar(s:Float):Mat3{
		var invS = 1/s;
		multiplyScalar(invS);
		return this;
	}

	public function determinant():Float{
		var a = this[0], b = this[1], c = this[ 2 ],
			d = this[3], e = this[4], f = this[ 5 ],
			g = this[6], h = this[7], i = this[ 8 ];
		return a * e * i - a * f * h - b * d * i + b * f * g + c * d * h - c * e * g;
	}

	public function transpose():Mat3{
		var _t:Float;
		_t = this[1]; this[1] = this[3]; this[3] = _t;
		_t = this[2]; this[2] = this[6]; this[6] = _t;
		_t = this[5]; this[5] = this[7]; this[7] = _t;
		return this;
	}

	public function clone():Mat3{
		return (new Mat3()).set(
			this[0], this[3], this[6],
			this[1], this[4], this[7],
			this[2], this[5], this[8]
		);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	public function toString():String{
		var str = 'Mat3(\n    ';
		for(i in 0...this.length){
			str += this[i];
			if(i < this.length - 1){
				str += ' ';
				if(i % 3 == 2) str += '\n    ';
			}
		}
		str += '\n)';
		return str;
	}
	
}