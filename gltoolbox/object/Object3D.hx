package gltoolbox.object;

import gltoolbox.math.Mat4;
import gltoolbox.math.Euler;
import gltoolbox.math.Euler.Order;
import gltoolbox.math.Vec3;

class Object3D{
		
	public var x(get, set):Float;//alias to localMatrix data
	public var y(get, set):Float;
	public var z(get, set):Float;

	public var scaleX(get, set):Float;
	public var scaleY(get, set):Float;
	public var scaleZ(get, set):Float;

	public var rotationX(get, set):Float;
	public var rotationY(get, set):Float;
	public var rotationZ(get, set):Float;

	public var userMatrix:Mat4; //extra transformation, multiplied by localMatrix
								//if modified, 'worldMatrixNeedsUpdate' should be set to true

	public var worldMatrix(get, never):Mat4; //computed from hierarchy

	public var children:Array<Object3D>;
	public var parent(default, null):Object3D;

	//private
	private var rotation:Euler;
	private var scale:Vec3;

	private var localMatrix(get, set):Mat4; //if modified, 'worldMatrixNeedsUpdate' should be set to true
	private var worldMatrixNeedsUpdate(get, set):Bool;
	private var localMatrixNeedsUpdate:Bool;
	//internal
	private var _worldMatrixNeedsUpdate:Bool;
	private var _worldMatrix:Mat4;
	private var _localMatrix:Mat4;

	public function new(){
		_localMatrix = (new Mat4()).identity();
		_worldMatrix = (new Mat4());
		userMatrix = null;

		rotation = new Euler(0, 0, 0, Order.XYZ);
		scale = new Vec3(1, 1, 1);

		children = new Array<Object3D>();
		
		worldMatrixNeedsUpdate = true;
		localMatrixNeedsUpdate = true;
	}

	public function add(child:Object3D):Object3D{
		children.push(child);
		child.parent = this;
		return this;
	}

	public function remove(child:Object3D):Object3D{
		var i = children.indexOf(child);
		if(i != -1){
			children.splice(i, 1);
			child.parent = null;
		}
		return this;
	}

	public inline function flagWorldMatrixNeedsUpdate(){
		worldMatrixNeedsUpdate = true;
	}


	//@! todo .clone()
	public function clone():Object3D{
		throw 'todo';
		return null;
	}

	//private
	private function updateWorldMatrix():Object3D{
		//W = L
		_worldMatrix.set(localMatrix);

		//W = U * W
		if(userMatrix != null)
			_worldMatrix.premultiply(userMatrix);

		//W = P * W
		if(parent != null)
			_worldMatrix.premultiply(parent.worldMatrix);

		worldMatrixNeedsUpdate = false;

		//flag the children for updates
		for(c in children)
			c.flagWorldMatrixNeedsUpdate();

		return this;
	}

	//properties
	//position
	private inline function get_x():Float return _localMatrix.x;
	private inline function get_y():Float return _localMatrix.y;
	private inline function get_z():Float return _localMatrix.z;
	private inline function set_x(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return _localMatrix.x = v;
	}
	private inline function set_y(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return _localMatrix.y = v;
	}
	private inline function set_z(v:Float):Float{
		worldMatrixNeedsUpdate = true;
		return _localMatrix.z = v;
	}

	//scale
	private inline function get_scaleX():Float return scale.x;
	private inline function get_scaleY():Float return scale.y;
	private inline function get_scaleZ():Float return scale.z;
	private inline function set_scaleX(v:Float):Float{
		localMatrixNeedsUpdate = true;
		return scale.x = v;
	}
	private inline function set_scaleY(v:Float):Float{
		localMatrixNeedsUpdate = true;
		return scale.y = v;
	}
	private inline function set_scaleZ(v:Float):Float{
		localMatrixNeedsUpdate = true;
		return scale.z = v;
	}

	//rotation
	private inline function get_rotationX():Float return rotation.x;
	private inline function get_rotationY():Float return rotation.y;
	private inline function get_rotationZ():Float return rotation.z;
	private inline function set_rotationX(v:Float):Float{
		localMatrixNeedsUpdate = true;
		return rotation.x = v;
	}
	private inline function set_rotationY(v:Float):Float{
		localMatrixNeedsUpdate = true;
		return rotation.y = v;
	}
	private inline function set_rotationZ(v:Float):Float{
		localMatrixNeedsUpdate = true;
		return rotation.z = v;
	}

	//local matrix
	private var _xyz:Vec3 = new Vec3();
	private inline function get_localMatrix():Mat4{
		if(localMatrixNeedsUpdate){
			//compose
			_xyz.set(x,y,z);
			_localMatrix.compose(_xyz, rotation, scale);
		}
		return _localMatrix;	
	}

	private inline function set_localMatrix(v:Mat4):Mat4{
		//@! need to decompose rotation
		throw 'incomplete: need to decompose matrix into properties';
		worldMatrixNeedsUpdate = true;
		return _localMatrix = v;
	}

	//world matrix
	private function get_worldMatrix():Mat4{
		if(worldMatrixNeedsUpdate){
			updateWorldMatrix();
		}
		return _worldMatrix;
	}

	private function get_worldMatrixNeedsUpdate():Bool{
		//check all parents
		return _worldMatrixNeedsUpdate || localMatrixNeedsUpdate || (parent != null && parent.worldMatrixNeedsUpdate);
	}

	private inline function set_worldMatrixNeedsUpdate(v:Bool):Bool{
		return _worldMatrixNeedsUpdate = v;
	}

}