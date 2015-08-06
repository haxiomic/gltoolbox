package gltoolbox.geometry;

import gltoolbox.core.Attribute;
import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.GLTools;
import gltoolbox.typedarray.Float32Array;

class Geometry2D extends Geometry{

	public function new(){
		super();
		vertexAttribute.itemSize = 2;
	}

	override private function updateVertexCount():Geometry{
		this.vertexCount = Std.int(this.vertices.length / 2);
		return this;
	}

}