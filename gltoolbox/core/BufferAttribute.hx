package gltoolbox.core;

import gltoolbox.gl.GLBuffer;

typedef BufferAttribute<T> = {
	>Attribute<T>,
	var itemSize:Int;
	var buffer:GLBuffer;
}