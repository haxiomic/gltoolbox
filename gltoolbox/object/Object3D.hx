/*
	Two channels,
	1 - Obvious, public facing .worldMatrix and .localMatrix

	2 - Cache controlled, doesn't account for changes to .localMatrix; used when there is knowledge of no changes
		- this means recalculating every draw, which is unnecessary
		- instead I think the interface should be designed to enforce triggering bool when values are changed
	
	updateLocalMatrix()
	updateWorldMatrix()
	
	var cacheInvalid;
	getWorldMatrixCached
	getLocalMatrixCached
*/

package gltoolbox.object;

import gltoolbox.math.Mat4;

class Object3D{
	
	//aliases to localMatrix data
	public var x(get, set):Float;
	public var y(get, set):Float;
	public var z(get, set):Float;

	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var scaleZ(get, set):Float;

	//@! how to handle rotation?

	//@! enforce @:isVar ?
	public var localMatrix(default, set):Mat4;//requires worldMatrixNeedsUpdate true when modified
	public var worldMatrix(get, null):Mat4;//computed from hierarchy

	public var children:Array<Object3D>;
	public var parent(get, null):Object3D;

	public var worldMatrixNeedsUpdate:Bool;

	//private

	public function new(){
		localMatrix = (new Mat4()).identity();
		worldMatrixNeedsUpdate = true;
	}

	public inline function add(child:Object3D):Object3D{
		children.push(child);
		return this;
	}

	public inline function remove(child:Object3D):Object3D{
		var i = children.indexOf(child);
		children.splice(i, 1);
		return this;
	}

	public function clone():Object3D{
		//@! need to check
		var o = new Object3D();
		o.parent = parent;
		o.localMatrix = localMatrix.clone();
		o.children = o.children.copy();
		return o;
	}

	//convenience
	public inline function setXYZ(x:Float, ?y:Float, ?z:Float):Object3D{
		if(y == null) y = x;
		if(z == null) z = y;

		worldMatrixNeedsUpdate = true;
		localMatrix.x = x;
		localMatrix.y = y;
		localMatrix.z = z;
		return this;
	}

	public inline function setScaleXYZ(scaleX:Float , ?scaleY:Float, ?scaleZ:Float):Object3D{
		if(scaleY == null) scaleY = scaleX;
		if(scaleZ == null) scaleZ = scaleY;

		worldMatrixNeedsUpdate = true;
		localMatrix.scaleX = scaleX;
		localMatrix.scaleY = scaleY;
		localMatrix.scaleZ = scaleZ;
		return this;
	}

	//properties
	//position alias
	private inline function get_x():Float return localMatrix.x;
	private inline function get_y():Float return localMatrix.y;
	private inline function get_z():Float return localMatrix.z;
	private inline function set_x(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return localMatrix.x = v;
	}
	private inline function set_y(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return localMatrix.y = v;
	}
	private inline function set_z(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return localMatrix.z = v;
	}

	//scale alias
	private inline function get_scaleX():Float return localMatrix.scaleX;
	private inline function get_scaleY():Float return localMatrix.scaleY;
	private inline function get_scaleZ():Float return localMatrix.scaleZ;
	private inline function set_scaleX(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return localMatrix.scaleX = v;
	}
	private inline function set_scaleY(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return localMatrix.scaleY = v;
	}
	private inline function set_scaleZ(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return localMatrix.scaleZ = v;
	}

	//@! rotation alias

	private inline function set_localMatrix(mat4:Mat4):Mat4{
		worldMatrixNeedsUpdate = true;
		return localMatrix = mat4;
	}

	private inline function get_worldMatrix():Mat4{
		throw 'todo';
		if(worldMatrixNeedsUpdate){
			//worldMatrix = parent.worldMatrix * localMatrix
		}
		return worldMatrix;
	}

}