package gltoolbox.geometry;

import gltoolbox.gl.GL;
import gltoolbox.typedarray.Float32Array;

class RegularPolygonGeometry extends Geometry2D{

	public var nSides(default, null):Int;

	public function new(nSides:Int, radius:Float = 1, angle:Float = 0, centerX:Float = 0, centerY:Float = 0){
		
		//triangle count = nSides - 2
		//vertex count = 3 * (nSides - 2)

		//nSides must be greater than 3!
		if(nSides < 3) return;

		this.nSides = nSides;

		//setup vertex memory
		var vertices = new Float32Array(2 * 3 * (nSides - 2));

		//zig-zag triangular decomposition
		//requires convex vertices in clockwise order
		var da = Math.PI * 2.0 / nSides;

		inline function vX(i:Int) return (Math.cos((i * da) + angle) * radius) + centerX;
		inline function vY(i:Int) return (Math.sin((i * da) + angle) * radius) + centerY;

		var vOffset:Int = 0;
		var a:Int = 0;          //forward counter
		var b:Int = nSides - 1; //backward counter
		var i:Int = 0;          //loop counter

		var _a, _b, _c;
		while(a < b - 1){
			_a = a;
			_b = b;
			_c = ((i++ % 2) == 0 ? ++a : --b);
			//add triangle _a, _b, _c
			this.vertices[vOffset++] = vX(_a);
			this.vertices[vOffset++] = vY(_a);
			this.vertices[vOffset++] = vX(_b);
			this.vertices[vOffset++] = vY(_b);
			this.vertices[vOffset++] = vX(_c);
			this.vertices[vOffset++] = vY(_c);
		}

		super(vertices, GL.TRIANGLES);
		updateVertexCount();
	}

}