package gltoolbox.geometry;

import gltoolbox.gl.GL;
import gltoolbox.typedarray.Float32Array;

class RegularPolygon extends Geometry2D{

	public var nSides(default, null):Int;

	public function new(nSides:Int, radius:Float = 1, angle:Float = 0, offsetX:Float = 0, offsetY:Float = 0){
		super();
		
		//triangle count = nSides - 2
		//vertex count = 3 * (nSides - 2)

		//nSides must be greater than 3!
		if(nSides < 3) return;

		this.nSides = nSides;

		//setup vertex memory
		this.vertices = new Float32Array(2 * 3 * (nSides - 2));

		//zig-zag triangular decomposition
		//requires vertices in clockwise order
		var da = Math.PI * 2.0 / nSides;
		var vOffset:Int = 0;

		inline function vX(i:Int) return (Math.cos((i * da) + angle) * radius) + offsetX;
		inline function vY(i:Int) return (Math.sin((i * da) + angle) * radius) + offsetY;
		function addTriangle(a:Int, b:Int, c:Int){ /* do not inline; haxe bug #4463 */
			this.vertices[vOffset++] = vX(a);
			this.vertices[vOffset++] = vY(a);
			this.vertices[vOffset++] = vX(b);
			this.vertices[vOffset++] = vY(b);
			this.vertices[vOffset++] = vX(c);
			this.vertices[vOffset++] = vY(c);
		}

		var f:Int = 0;          //forward counter
		var b:Int = nSides - 1; //backward counter
		var i:Int = 0;          //loop counter

		while(f < b - 1){
			addTriangle(f, b, ((i++ % 2) == 0 ? ++f : --b));
		}

		this.drawMode = GL.TRIANGLES;
		updateVertexCount();
	}

}