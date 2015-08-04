/*
	@! out of sync
*/

package gltoolbox.render;

import gltoolbox.gl.GL;
import gltoolbox.buffer.BufferTools;
import gltoolbox.geometry.Quad;

class RenderTools{

	//static texture quad (0,0)->(1,1)
	//only need one on GPU for many common operations
	static public var textureQuad(get, null):GLBuffer;
	static inline public var textureQuadDrawMode:Int = GL.TRIANGLE_STRIP;

	static function get_textureQuad():GLBuffer{
		if(textureQuad == null || !GL.isBuffer(textureQuad)){
			textureQuad = BufferTools.uploadVerticies(Quad.unitQuadVertices(textureQuadDrawMode), GL.STATIC_DRAW);
		}
		return textureQuad;
	}
	
}