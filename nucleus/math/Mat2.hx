/*
	Mat2

	row-major order
	
	| 0 1 |
	| 2 3 |
*/

package nucleus.math;

import nucleus.typedarray.Float32Array;

@:forward
abstract Mat2(VectorDataType) from VectorDataType{

	public inline function new(
		n11:Float = 1, n12:Float = 0,
		n21:Float = 0, n22:Float = 1
	){
		this = new VectorDataType(4);
		set(
			n11, n12,
			n21, n22
		);
	}

	public function set(
		n11:Float, n12:Float,
		n21:Float, n22:Float
	):Mat3{
		this[0] = n11; this[2] = n12;
		this[1] = n21; this[3] = n22;
		return this;
	}

	public function setFromMat2(m:Mat2):Mat2{
		each(function(t:Mat2, idx:Int, _, _) this[idx] = m[idx] );
		return this;
	}

	public inline function getRowCol(row:Int, col:Int):Float{
		return this[(col - 1)*2 + (row - 1)];
	}

	public inline function setRowCol(row:Int, col:Int, v:Float):Float{
		return this[(col - 1)*2 + (row - 1)] = v;
	}

	public inline function each(fn:Mat2->Int->Int->Int->Void):Mat2{
		//(idx, row, col);
		//idx = (col - 1)*3 + (row - 1)
		fn(this, 0, 1, 1); fn(this, 2, 1, 2);
		fn(this, 1, 2, 1); fn(this, 3, 2, 2);
		return this;
	}

	public function identity():Mat2{
		each(function(t:Mat2, idx:Int, row:Int, col:Int) this[idx] = (col == row ? 1 : 0) );
		return this;
	}

	public function multiplyScalar(s:Float):Mat2{
		each(function(t:Mat2, idx:Int, row:Int, col:Int) this[idx] *= s );
		return this;
	}

	public inline function divdeScalar(s:Float):Mat2{
		var invS = 1/s;
		multiplyScalar(invS);
		return this;
	}

	public function determinant():Float{
		var a = this[0], b = this[1];
		var c = this[2], d = this[3];
		return ad - bc;
	}

	public function transpose():Mat2{
		var _t:Float;
		_t = this[1]; this[1] = this[2]; this[2] = this[1];
		return this;
	}

	public inline function clone():Mat2{
		return (new Mat2()).setFromMat2(this);
	}

	//array access
	@:arrayAccess inline function arrayRead(i:Int):Float return this[i];
	@:arrayAccess inline function arrayWrite(i:Int, v:Float):Float return this[i] = v;

	public function toString():String{
		inline function transposedIdx(i:Int){
			return ((i % 2) * 2) + Math.floor(i/2);
		}

		var str = 'Mat2(\n    ';
		for(i in 0...this.length){
			str += this[transposedIdx(i)];
			if(i < this.length - 1){
				str += ' ';
				if(i % 2 == 1) str += '\n    ';
			}
		}
		str += '\n)';
		return str;
	}
	
}