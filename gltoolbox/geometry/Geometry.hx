/*
	@! todo
	#Custom Attributes

	#Dynamic Geometry
	- dynamic geometry with an update() function
	- with verticesNeedUpdate and isDynamic

*/

package gltoolbox.geometry;

import gltoolbox.core.Attribute;
import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.GLTools;
import gltoolbox.typedarray.Float32Array;

class Geometry{

	public var vertices(get, set):Float32Array; //alias to vertex attribute data
	public var vertexCount(default, null):Int;

	//rendering
	public var drawMode:Int = GL.TRIANGLES;
	public var vertexAttribute:BufferAttributeData<Float32Array>;
	public var attributes:Map<String, Attribute>;

	public function new(){
		vertexAttribute = {
			data: null,
			itemSize: 0,
			buffer: null
		}

		attributes = [
			'position' => BufferAttribute(vertexAttribute)
		];
	}

	public inline function upload():Geometry{
		vertexAttribute.buffer = GLTools.uploadArray(vertexAttribute.data, GL.STATIC_DRAW);
		return this;
	}

	//private
	private function updateVertexCount():Geometry{
		return this;
	}

	//properties
	private inline function get_vertices():Float32Array return vertexAttribute.data;
	private inline function set_vertices(v:Float32Array):Float32Array return vertexAttribute.data = v;

}