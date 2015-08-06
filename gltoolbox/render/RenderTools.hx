/*
	@! out of sync
*/

package gltoolbox.render;

import gltoolbox.gl.GL;
import gltoolbox.buffer.BufferTools;
import gltoolbox.geometry.Rectangle;

class RenderTools{

	//static texture quad (0,0)->(1,1)
	//only need one on GPU for many common operations
	static public var textureQuad(get, null):Rectangle;

	static function get_textureQuad():GLBuffer{
		if(textureQuad == null){
			textureQuad = new Rectangle.Unit();
			textureQuad.upload();
		}
		return textureQuad;
	}
	
}