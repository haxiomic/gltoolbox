/*
	Unified Orientation
*/

package gltoolbox.math;

enum OrientationType{
	Quat(q:Quat);
	Euler(e:Euler);
	Mat4(m:Mat4);
}

abstract Orientation(OrientationType) from OrientationType to OrientationType {

	public function clone():Orientation{
		return switch this{
			case Quat(q): q.clone();
			case Euler(e): e.clone();
			case Mat4(m): m.clone();
		}
	}

	//@! todo conversions
	//@! should clone out instead of return this for consistent behavior?
	@:to function toQuat():Quat{
		switch this{
			case Quat(q):
				return q;
			case Euler(e):
				var c1 = Math.cos(e.swappedX/2); var s1 = Math.sin(e.swappedX/2);
				var c2 = Math.cos(e.swappedY/2); var s2 = Math.sin(e.swappedY/2);
				var c3 = Math.cos(e.swappedZ/2); var s3 = Math.sin(e.swappedZ/2);
				return new Quat(
					s1 * c2 * c3 + c1 * s2 * s3,
					c1 * s2 * c3 - s1 * c2 * s3,
					c1 * c2 * s3 + s1 * s2 * c3,
					c1 * c2 * c3 - s1 * s2 * s3
				);
			case Mat4(m):
				throw 'not implemented';
		}

		return null;
	}
	@:to function toEuler():Euler{
		switch this{
			case Quat(q):
				throw 'not implemented';
			case Euler(e):
				return e;
			case Mat4(m):
				throw 'not implemented';
		}

		return null;
	}
	@:to function toMat4():Mat4{
		switch this{
			case Quat(q):
				throw 'not implemented';
			case Euler(e):
				throw 'not implemented';
			case Mat4(m):
				return m;
		}

		return null;
	}

	@:from static inline function fromQuat(q:Quat):Orientation return Quat(q);
	@:from static inline function fromEuler(e:Euler):Orientation return Euler(e);
	@:from static inline function fromMat4(m:Mat4):Orientation return Mat4(m);
}