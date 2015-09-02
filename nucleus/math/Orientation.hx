/*
	Unified Orientation
*/

package nucleus.math;

enum OrientationType{
	Quat(q:Quat);
	Euler(e:Euler);
	Mat4(m:Mat4);
}

abstract Orientation(OrientationType) from OrientationType to OrientationType {

	public inline function new(o:Orientation){
		this = o;
	}

	public inline function setFromOrientation(o:Orientation):Orientation{
		switch o{
			case Quat(q): setFromQuat(q);
			case Euler(e): setFromEuler(e);
			case Mat4(m): setFromMat4(m);
		}
		return this;
	}
	public inline function setFromQuat(sq:Quat):Orientation{
		switch this{
			case Quat(q): q.setFromQuat(sq);
			case Euler(e): e.setFromQuat(sq);
			case Mat4(m): m.setFromQuat(sq);
		}
		return this;
	}
	public inline function setFromEuler(se:Euler):Orientation{
		switch this{
			case Quat(q): q.setFromEuler(se);
			case Euler(e): e.setFromEuler(se);
			case Mat4(m): m.setFromEuler(se);
		}
		return this;
	}
	public inline function setFromMat4(sm:Mat4):Orientation{
		switch this{
			case Quat(q): q.setFromMat4(sm);
			case Euler(e): e.setFromMat4(sm);
			case Mat4(m): m.setFromMat4(sm);
		}
		return this;
	}

	public inline function clone():Orientation{
		return switch this{
			case Quat(q): q.clone();
			case Euler(e): e.clone();
			case Mat4(m): m.clone();
		}
	}

	//@! should clone out when type is the same for consistent behavior?
	@:to
	public inline function toQuat():Quat{
		return switch this{
			case Quat(q): q;
			case Euler(e): (new Quat()).setFromEuler(e);
			case Mat4(m): (new Quat()).setFromMat4(m);
		}
	}
	@:to
	public inline function toEuler():Euler{
		return switch this{
			case Quat(q): (new Euler()).setFromQuat(q);
			case Euler(e): e;
			case Mat4(m): (new Euler()).setFromMat4(m);
		}
	}
	@:to
	public inline function toMat4():Mat4{
		return switch this{
			case Quat(q): (new Mat4()).setFromQuat(q);
			case Euler(e): (new Mat4()).setFromEuler(e);
			case Mat4(m): m;
		}
	}

	@:from static public inline function fromQuat(q:Quat):Orientation return Quat(q);
	@:from static public inline function fromEuler(e:Euler):Orientation return Euler(e);
	@:from static public inline function fromMat4(m:Mat4):Orientation return Mat4(m);
	
}