//@! undecided on this class at the moment
//what about normals and other types of data?

import gltoolbox.typedarray.Float32Array;

typedef VertexDataType = Float32Array;

typedef VertexData = {
	var vertices:VertexDataType;
	var count:Int;
	var elementsPerVertex:Int;
}