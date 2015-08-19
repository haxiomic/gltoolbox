/*
	- Questions
		- efficient type casing (yes, render object)
		- grouping sub classes
*/

import gltoolbox.object.Object3D;
import gltoolbox.object.Mesh;

abstract RenderObject(Dynamic) from Dynamic to Mesh to Cube to Tri{}

class Cube extends Mesh{
	public function new(){
		super(null, null);
	}
}

class Tri extends Cube{
	public var prop:String = "coolio";
	public function new(){
		super();
	}
}

class Quad extends Tri{
	public function new(){
		super();
	}
}

class Main{

	static public function main(){
		var o3d = new Object3D();
		var mesh = new Mesh(null, null);
		var mesh2 = new Mesh(null, null);
		var cube = new Cube();

		var objects = new Array<Object3D>();
		objects.push(o3d);
		objects.push(mesh);
		objects.push(mesh2);
		objects.push(cube);
		objects.push(new Tri());
		objects.push(new Quad());

		trace('Method 2');
		for(obj in objects){
			var o : RenderObject = obj;
			var c = Type.getClass(o);
			switch c{
				case Mesh:
					trace('is Mesh, (o:Mesh).visible = ${(o:Mesh).visible}');
				case Object3D:
					trace('is Object3D');
				case Cube:
					trace('is Cube');
				case Tri:
					trace('is Tri: ${(o:Tri).prop}');
				case Quad:
					trace('is Quad');
				default:
					trace('is unknown');
			}
		}
	}

}