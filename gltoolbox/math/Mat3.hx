/*
	Mat3

	row-major order
*/

package gltoolbox.math;

import gltoolbox.typedarray.Float32Array;

abstract Mat3(VectorDataType) from VectorDataType{

	public inline function new(
		n11:Float = 1, n12:Float = 0, n13:Float = 0,
		n21:Float = 0, n22:Float = 1, n23:Float = 0,
		n31:Float = 0, n32:Float = 0, n33:Float = 1
	){
		this = new VectorDataType(9);
		set(
			n11, n12, n13,
			n21, n22, n23,
			n31, n32, n33
		);
	}

	public function set(
		n11:Float, n12:Float, n13:Float,
		n21:Float, n22:Float, n23:Float,
		n31:Float, n32:Float, n33:Float
	):Mat3{
		this[0] = n11; this[3] = n12; this[6] = n13;
		this[1] = n21; this[4] = n22; this[7] = n23;
		this[2] = n31; this[5] = n32; this[8] = n33;
		return this;
	}

	public function setFromMat3(m:Mat3):Mat3{
		each(function(t:Mat3, idx:Int, _, _) this[idx] = m[idx] );	
		return this;
	}

	public inline function getRowCol(row:Int, col:Int):Float{
		return this[(col - 1)*3 + (row - 1)];
	}

	public inline function setRowCol(row:Int, col:Int, v:Float):Float{
		return this[(col - 1)*3 + (row - 1)] = v;
	}

	public inline function each(fn:Mat3->Int->Int->Int->Void):Mat3{
		//(idx, row, col);
		//idx = (col - 1)*3 + (row - 1)
		fn(this, 0, 1, 1); fn(this, 3, 1, 2); fn(this, 6, 1, 3);
		fn(this, 1, 2, 1); fn(this, 4, 2, 2); fn(this, 7, 2, 3);
		fn(this, 2, 3, 1); fn(this, 5, 3, 2); fn(this, 8, 3, 3);
		return this;
	}

	public function identity():Mat3{
		each(function(t:Mat3, idx:Int, row:Int, col:Int) this[idx] = (col == row ? 1 : 0) );
		return this;
	}

	public function multiplyScalar(s:Float):Mat3{
		each(function(t:Mat3, idx:Int, row:Int, col:Int) this[idx] *= s );
		return this;
	}

	public inline function divdeScalar(s:Float):Mat3{
		var invS = 1/s;
		multiplyScalar(invS);
		return this;
	}

	public function determinant():Float{
		var a = this[0], b = this[1], c = this[2],
		var d = this[3], e = this[4], f = this[5],
		var g = this[6], h = this[7], i = this[8];
		return a * e * i - a * f * h - b * d * i + b * f * g + c * d * h - c * e * g;
	}

	public function transpose():Mat3{
		var _t:Float;
		_t = this[1]; this[1] = this[3]; this[3] = _t;
		_t = this[2]; this[2] = this[6]; this[6] = _t;
		_t = this[5]; this[5] = this[7]; this[7] = _t;
		return this;
	}

	public inline function clone():Mat3{
		return (new Mat3()).setFromMat3(this);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	@:to inline function toFloat32Array():Float32Array return this;

	public function toString():String{
		inline function transposedIdx(i:Int){
			return ((i % 3) * 3) + Math.floor(i/3);
		}

		var str = 'Mat3(\n    ';
		for(i in 0...this.length){
			str += this[transposedIdx(i)];
			if(i < this.length - 1){
				str += ' ';
				if(i % 3 == 2) str += '\n    ';
			}
		}
		str += '\n)';
		return str;
	}
	
}