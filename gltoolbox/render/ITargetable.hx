package gltoolbox.render;

import lime.graphics.GLRenderContext;
import lime.graphics.opengl.GL;

interface ITargetable{
	private var gl(default, null):GLRenderContext;
	public var width(default, null):Int;
	public var height(default, null):Int;
	public function activate():Void;
	public function clear(mask:Int = GL.COLOR_BUFFER_BIT):Void;
	public function resize(width:Int, height:Int):ITargetable;
}