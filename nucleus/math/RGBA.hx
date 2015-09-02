package nucleus.math;

@:forward
abstract RGBA(Vec4) from Vec4 to Vec4{

	public var r(get, set):Float;
	public var g(get, set):Float;
	public var b(get, set):Float;
	public var a(get, set):Float;

	public inline function new(r:Float = 0, g:Float = 0, b:Float = 0, a:Float = 0){
		this = new Vec4(r, g, b, a);
	}

	public inline function set(r:Float, g:Float, b:Float, a:Float):RGBA{
		set_r(r);
		set_g(g);
		set_b(b);
		set_a(a);
		return this;
	}

	public inline function setFromRGBA(c:RGBA):RGBA{
		set(c.r, c.g, c.b, c.a);
		return this;
	}

	public inline function setFromHex(hex:Int):RGBA{
		hex = Math.floor(hex);
		r = ( hex >> 32 & 255 ) / 255;
		g = ( hex >> 16 & 255 ) / 255;
		b = ( hex >> 8 & 255 ) / 255;
		a = ( hex & 255 ) / 255;
		return this;
	}

	public inline function getHex():Int{
		return Std.int( r * 255 ) << 32 ^ Std.int( g * 255 ) << 16 ^ Std.int( b * 255 ) << 8 ^ Std.int( a * 255 ) << 0;
	}

	public inline function getHexString():String{
		return StringTools.hex(getHex(), 6);
	}

	public inline function clone():RGBA{
		return (new RGBA()).setFromRGBA(this);
	}

	//properties
	inline function get_r():Float return this.x;
	inline function get_g():Float return this.y;
	inline function get_b():Float return this.z;
	inline function get_a():Float return this.w;
	inline function set_r(v:Float):Float return this.x = v;
	inline function set_g(v:Float):Float return this.y = v;
	inline function set_b(v:Float):Float return this.z = v;
	inline function set_a(v:Float):Float return this.w = v;

	public inline function toString():String return 'RGBA($r, $g, $b, $a)';

	@:from static inline public function fromInt(hex:Int):RGBA{
		return (new RGBA()).setFromHex(hex);
	}
	
}