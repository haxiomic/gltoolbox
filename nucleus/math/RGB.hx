package nucleus.math;

@:forward
abstract RGB(Vec3) from Vec3 to Vec3{

	public var r(get, set):Float;
	public var g(get, set):Float;
	public var b(get, set):Float;

	public inline function new(r:Float = 0, g:Float = 0, b:Float = 0){
		this = new Vec3(r, g, b);
	}

	public inline function set(r:Float, g:Float, b:Float):RGB{
		set_r(r);
		set_g(g);
		set_b(b);
		return this;
	}

	public inline function setFromRGB(c:RGB):RGB{
		set(c.r, c.g, c.b);
		return this;
	}

	public inline function setFromHex(hex:Int):RGB{
		hex = Math.floor(hex);
		r = ( hex >> 16 & 255 ) / 255;
		g = ( hex >> 8 & 255 ) / 255;
		b = ( hex & 255 ) / 255;
		return this;
	}

	public inline function getHex():Int{
		return Std.int( r * 255 ) << 16 ^ Std.int( g * 255 ) << 8 ^ Std.int( b * 255 ) << 0;
	}

	public inline function getHexString():String{
		return StringTools.hex(getHex(), 6);
	}

	public inline function clone():RGB{
		return (new RGB()).setFromRGB(this);
	}

	//properties
	inline function get_r():Float return this.x;
	inline function get_g():Float return this.y;
	inline function get_b():Float return this.z;
	inline function set_r(v:Float):Float return this.x = v;
	inline function set_g(v:Float):Float return this.y = v;
	inline function set_b(v:Float):Float return this.z = v;

	public inline function toString():String return 'RGB($r, $g, $b)';

	@:from static inline public function fromInt(hex:Int):RGB{
		return (new RGB()).setFromHex(hex);
	}
	
}