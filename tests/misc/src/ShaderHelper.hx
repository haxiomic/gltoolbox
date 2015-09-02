package;

import nucleus.math.Vec2;
import nucleus.math.Vec3;
import nucleus.math.Color;
import nucleus.typedarray.Float32Array;

/*
-- GLSL     :: Haxe --
//uniforms
Float       :: Float
Int         :: Int
Bool        :: Bool
Vec2        :: Vec2
Vec3        :: Vec3
Vec4        :: Vec4
BVec2       :: Array<Bool>? Int32Array?
BVec3       :: Array<Bool>?
BVec4       :: Array<Bool>?
IVec2       :: Vec2 or Int32Array?
IVec3       :: Vec3
IVec4       :: Vec4
Mat2        :: Mat2?
Mat3        :: Mat3
Mat4        :: Mat4
Sampler2D   :: Texture
SamplerCube :: CubeMap
UserType    :: ??
Array<T>    :: ??
//BufferPointer on the way

//attributes
Float       :: Float
Vec2        :: Vec2
Vec3        :: Vec3
Vec4        :: Vec4
Array<T:Float, Vec2, Vec3, Vec4>
BufferPointer(Array<T:Float, Vec2, Vec3, Vec4>)
*/

class Float32ArrayHelper{
	static public function uploadAsUniform(v:Float32Array, loc:Int){
		trace('Float32Array uploadAsUniform $v');
	}
	static public function uploadAsAttribute(v:Float32Array, loc:Int){
		trace('Float32Array uploadAsAttribute $v');	
	}
}

class Vec2Helper{
	static public function uploadAsUniform(v:Vec2, loc:Int){
		trace('Vec2 uploadAsUniform $v');
	}
	static public function uploadAsAttribute(v:Vec2, loc:Int){
		trace('Vec2 uploadAsAttribute $v');	
	}
}

class Vec3Helper{
	static public function uploadAsUniform(v:Vec3, loc:Int){
		trace('Vec3 uploadAsUniform $v');
	}
	static public function uploadAsAttribute(v:Vec3, loc:Int){
		trace('Vec3 uploadAsAttribute $v');	
	}
}