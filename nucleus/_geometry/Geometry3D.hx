package nucleus.geometry;

import nucleus.core.Attribute;
import nucleus.gl.GL;
import nucleus.gl.GLBuffer;
import nucleus.GPU;
import nucleus.typedarray.Float32Array;

class Geometry3D extends Geometry{

	public function new(vertices:Float32Array, drawMode:Int = GL.TRIANGLES){
		super(vertices, drawMode);
		vertexAttribute.itemSize = 3;
	}

}