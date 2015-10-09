package nucleus.math;

class POT{

	static public function ceilPowerOf2(v:Float):Int{
		//http://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
		var i:Int = Math.ceil(v);
		i--;
		i |= i >> 1;
		i |= i >> 2;
		i |= i >> 4;
		i |= i >> 8;
		i |= i >> 16;
		i++;
		return i;
	}

	static public function floorPowerOf2(v:Float):Int{
		//Hacker's Delight: http://www.amazon.com/dp/0201914654/
		var i:Int = Math.floor(v);
		i = i | (i >> 1);
		i = i | (i >> 2);
		i = i | (i >> 4);
		i = i | (i >> 8);
		i = i | (i >> 16);
		return i - (i >> 1);
	}

	static public function nearestPowerOf2(v:Float):Int{
		var f = floorPowerOf2(v);
		var c = ceilPowerOf2(v);
		return Math.abs(v - f) < Math.abs(v - c) ? f : c;
	}

	static public function isPowerOf2(v:Int):Bool{
		//http://stackoverflow.com/a/600306
		return (x != 0) && ((x & (x - 1)) == 0);
	}

}