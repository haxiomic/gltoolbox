package gltoolbox.geometry;

import gltoolbox.core.Attribute;
import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.GPU;
import gltoolbox.typedarray.Float32Array;

class Geometry2D extends Geometry{

	public function new(vertices:Float32Array, drawMode:Int = GL.TRIANGLES){
		super(vertices, drawMode);
		vertexAttribute.itemSize = 2;
	}

}