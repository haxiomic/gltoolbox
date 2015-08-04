package gltoolbox.geometry;

import gltoolbox.gl.GL;

class Quad{

	static public function rectangleVertices(
		originX:Float = 0,
		originY:Float = 0,
		width:Float   = 1,
		height:Float  = 1,
		drawMode:Int  = GL.TRIANGLE_STRIP
	):Array<Float>{

		var vertices:Array<Float>;

		switch (drawMode) {
			case GL.TRIANGLE_STRIP, GL.TRIANGLES:
				vertices = [//anti-clockwise triangle strip
					originX,        originY+height,     //  0---2
					originX,        originY,            //  |  /|
					originX+width,  originY+height,     //  | / |
					originX+width,  originY,            //  1---3
					//TRIANGLE_STRIP builds triangles with the pattern, v0, v1, v2 | v2, v1, v3
					//by default, anti-clockwise triangles are front-facing 
				];
				if(drawMode == GL.TRIANGLES){
					vertices = vertices.concat([        //  *---4
						originX+width,  originY+height, //  |  /|
						originX,        originY,        //  | / |
					]);                                 //  5---*
				}
			case GL.TRIANGLE_FAN:
				vertices = [//anti-clockwise triangle strip
					originX,        originY+height,     //  0---3
					originX,        originY,            //  |\  |
					originX+width,  originY,            //  | \ |
					originX+width,  originY+height,     //  1---2
					//TRIANGLE_STRIP builds triangles with the pattern, v0, v1, v2 | v2, v1, v3
					//by default, anti-clockwise triangles are front-facing 
				];
		}

		return vertices;
	}

	static public inline function unitQuadVertices(drawMode:Int = GL.TRIANGLE_STRIP):Array<Float>{
		return rectangleVertices(0, 0, 1, 1, drawMode);
	}

	static public inline function clipSpaceQuadVertices(drawMode:Int = GL.TRIANGLE_STRIP):Array<Float>{
		return rectangleVertices(-1, -1, 2, 2, drawMode);
	}

	static public function rectangleEdgeVertices(
		originX:Float = 0,
		originY:Float = 0,
		width:Float   = 1,
		height:Float  = 1
	):Array<Float>{
		
		/*  
		*   OpenGL line drawing
		*   +--X--+-----+-----+
		*   |  '  |     |     |
		*   O---->---->---->--X
		*   |  '  |     |     |
		*   +--^--+-----+-----+
		*   |  '  |     |     |
		*   |  ^  |     |     |
		*   |  '  |     |     |
		*   +--O--+-----+-----+
		*   lines are centered on the boundary between pixels
		*/

		//clockwise order
		return [
			//top
			originX+0         , originY+height-0.5 ,
			originX+width     , originY+height-0.5 ,
			//right
			originX+width-0.5 , originY+height     ,
			originX+width-0.5 , originY+0          ,
			//bottom
			originX+width     , originY+0.5        ,
			originY+0         , originY+0.5        ,
			//left
			originX+0.5       , originY+0          ,
			originX+0.5       , originY+height
		];
	}

}