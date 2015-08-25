package gltoolbox.geometry;

import gltoolbox.gl.GL;
import gltoolbox.typedarray.Float32Array;

class RectangleGeometry extends Geometry2D{

	public function new(originX:Float, originY:Float, width:Float, height:Float){
		super(new Float32Array([
			originX,        originY+height, //top left
			originX,        originY,        //bottom left
			originX+width,  originY+height, //top right

			originX+width,  originY,        //bottom right
			originX+width,  originY+height, //top left
			originX,        originY         //bottom left
		]), GL.TRIANGLES);

		updateVertexCount();
	}

}


//special cases
abstract Unit(RectangleGeometry) to RectangleGeometry from RectangleGeometry{

	public function new(){
		this = new RectangleGeometry(0, 0, 1, 1);
	}

}

abstract ClipSpace(RectangleGeometry) to RectangleGeometry from RectangleGeometry{

	public function new(){
		this = new RectangleGeometry(-1, -1, 2, 2);
	}
	
}