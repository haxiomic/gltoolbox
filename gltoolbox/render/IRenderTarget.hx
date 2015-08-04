package gltoolbox.render;

import gltoolbox.gl.GL;

interface IRenderTarget{

	public var width(default, null):Int;
	public var height(default, null):Int;
	public function activate():Void;
	public function clear(mask:Int = GL.COLOR_BUFFER_BIT):Void;
	public function resize(width:Int, height:Int):Void;
	
}