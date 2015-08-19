package gltoolbox.geometry;

import gltoolbox.core.Attribute;
import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.GPU;
import gltoolbox.typedarray.Float32Array;

class Geometry3D extends Geometry{

	public function new(){
		super();
		vertexAttribute.itemSize = 3;
	}

}