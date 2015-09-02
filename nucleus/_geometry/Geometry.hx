/*
	@! todo

	#Dynamic Geometry
	- dynamic geometry with an update() function
	- with verticesNeedUpdate and isDynamic

*/

package nucleus.geometry;

import nucleus.core.Attribute;
import nucleus.gl.GL;
import nucleus.gl.GLBuffer;
import nucleus.GPU;
import nucleus.typedarray.Float32Array;

class Geometry{

	public var vertices(get, set):Float32Array; //alias to vertex attribute data
	public var vertexCount(default, null):Int;

	//rendering
	public var drawMode:Int;
	public var vertexAttribute:BufferAttributeData<Float32Array>;
	public var attributes:Map<String, Attribute>;

	public function new(vertices:Float32Array, drawMode:Int = GL.TRIANGLES){
		vertexAttribute = {
			data: null,
			itemSize: 1, //set by subclasses
			usage: GL.STATIC_DRAW,
			buffer: null
		}

		attributes = [
			'position' => BufferAttribute(vertexAttribute)
		];

		this.vertices = vertices;
		this.drawMode = drawMode;
	}

	//@! todo .clone()

	//private
	private function updateVertexCount():Geometry{
		this.vertexCount = Std.int(this.vertices.length / vertexAttribute.itemSize);
		return this;
	}

	//properties
	private inline function get_vertices():Float32Array return vertexAttribute.data;
	private inline function set_vertices(v:Float32Array):Float32Array return vertexAttribute.data = v;

}