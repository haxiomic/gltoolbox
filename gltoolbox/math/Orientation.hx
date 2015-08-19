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
	//@! should convesions be on the objects instead so we don't need to create new objects?
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
				var qx = q.x, qy = q.y, qz = q.z, qw = q.w;
				var x2 = qx + qx, y2 = qy + qy, z2 = qz + qz;
				var xx = qx * x2, xy = qx * y2, xz = qx * z2;
				var yy = qy * y2, yz = qy * z2, zz = qz * z2;
				var wx = qw * x2, wy = qw * y2, wz = qw * z2;
				return new Mat4(
					1 - (yy + zz), xy - wz,       xz + wy,       0,
					xy + wz,       1 - (xx + zz), yz - wx,       0,
					xz - wy,       yz + wx,       1 - (xx + yy), 0,
					0,             0,             0,             1
				);
			case Euler(e):
				var cx = Math.cos(e.swappedX); var sx = Math.sin(e.swappedX);
				var cy = Math.cos(e.swappedY); var sy = Math.sin(e.swappedY);
				var cz = Math.cos(e.swappedZ); var sz = Math.sin(e.swappedZ);
				return new Mat4(
					 cy*cz,  cx*sz + sx*sy*cz, sx*sz - cx*sy*cz, 0,
					-cy*sz,  cx*cz - sx*sy*sz, sx*cz + cx*sy*sz, 0,
					 sy,    -sx*cy,            cx*cy,            0,
					 0,      0,                0,                1
				);
			case Mat4(m):
				return m;
		}

		return null;
	}

	@:from static inline function fromQuat(q:Quat):Orientation return Quat(q);
	@:from static inline function fromEuler(e:Euler):Orientation return Euler(e);
	@:from static inline function fromMat4(m:Mat4):Orientation return Mat4(m);
}