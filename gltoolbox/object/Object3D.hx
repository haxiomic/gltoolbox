package gltoolbox.object;

import gltoolbox.math.Mat4;

class Object3D{

	public var x:Float;
	public var y:Float;
	public var z:Float;
	public var position:Vec3;
	public var rotation:Vec3;
	public var scale:Vec3;

	public var localMatrix(get, null):Mat4;
	public var worldMatrix(get, null):Mat4;
	public var children:Array<Object3D>;
	public var parent(get, null):Object3D;

	public var worldMatrixNeedsUpdate:Bool;

	public function new(){

	}

	public function add(child:Object3D):Object3D{
		children.push(child);
		return this;
	}

	public function remove(child:Object3D):Object3D{
		var i = children.indexOf(child);
		children.splice(i, 1);
	}

	//properties
	//position alias
	private inline function get_x():Float return position.x;
	private inline function get_y():Float return position.y;
	private inline function get_z():Float return position.z;
	private inline function set_x(v:Float):Float return position.x = v;
	private inline function set_y(v:Float):Float return position.y = v;
	private inline function set_z(v:Float):Float return position.z = v;

	private function get_worldMatrix():Mat4{
		throw 'todo';
		//if worldMatrixNeedsUpdate
			//worldMatrix = parent.worldMatrix * localMatrix
			//update cache
		//return cache
		return null;
	}

	private function get_localMatrix():Mat4{
		//compose from pos, rot, scale, quat
		throw 'todo';
		return null;
	}

	private function set_localMatrix(matrix:Mat4):Mat4{
		//decompose into pos, rot, scale, quat
		throw 'todo';
		return null;
	}

}

//if mat4 was a class
class ObsvMat4 extends mat4{
	var callback:fn;

	@:arrayWrite function(i, v){
		callback();
		elements[i] = v;
	}
}

localMatrix.onChange(function(){needsUpdate = true;});


/*
	#Invalidating the world matrix
	- change any part of local matrix
	- reassign the local matrix (easy)

	1. how to detect change to local matrix?
	2. how to invalidate children efficiently?

	----
	Option 1,

	Some clever observable versions of Vectors

	Option 2,

	Cache a copy of localMatrix the last time worldMatrix was updated, when we run get_worldMatrix, compare values
	(no worldMatrixNeedsUpdate)
	-> this works, but it means comparing 16 values in each object up the tree when we run get_worldMatrix
*/

/*
	three.js has updateMatrixWorld which updates all children down the tree
*/