package gltoolbox.shader;

import gltoolbox.gl.GLUniformLocation;
import gltoolbox.gl.GLProgram;

/*
ShaderDataType requirements
- must be auto converted from build in types
- flag on change
*/

//uniforms
Float
Int
Bool
Vec2
Vec3
Vec4
BVec2
BVec3
BVec4
IVec2
IVec3
IVec4
Mat2
Mat3
Mat4
Sampler2D //actually just an int referencing one of the texture slots
SamplerCube
UserType
//BufferPointer on the way
Array<T>

//attributes
Float
Vec2
Vec3
Vec4
Array<T:Float, Vec2, Vec3, Vec4>
BufferPointer(Array<T:Float, Vec2, Vec3, Vec4>)

class ShaderDataType{
	var needsUpload:Bool;
	public function upload():ShaderDataType;
}


class ShaderFloat implements ShaderDataType{};
class ShaderInt implements ShaderDataType{};
class ShaderBool implements ShaderDataType{};
class ShaderVec2 implements ShaderDataType{};
class ShaderVec3 implements ShaderDataType{};
class ShaderVec4 implements ShaderDataType{};
class ShaderBVec2 implements ShaderDataType{};//alias for IVec?
class ShaderBVec3 implements ShaderDataType{};
class ShaderBVec4 implements ShaderDataType{};
class ShaderIVec2 implements ShaderDataType{};//wraps Int32Array
class ShaderIVec3 implements ShaderDataType{};
class ShaderIVec4 implements ShaderDataType{};
class ShaderMat2 implements ShaderDataType{};
class ShaderMat3 implements ShaderDataType{};
class ShaderMat4 implements ShaderDataType{};
class ShaderSampler2D implements ShaderDataType{};
class ShaderSamplerCube implements ShaderDataType{};
class ShaderUserType implements ShaderDataType{}(name:string); // or Struct

class SpecialVec2{
	var data:Float32Array;
	var offset:Int;
	var size:Int = 2;//stride
	var x;
	var y;
}

class ShaderArray<T:ShaderDataType> implements ShaderDataType{
	var data:ArrayBufferView;
	var items:Array<T>;

	//array of Vec2s or Floats, or Mat4s ...

	public function new(count:Int){
		switch type{
			case Vec2:
				itemSize = 2;
				data = new Float32Array(itemSize * count);
		}
	}

	@:arrayAccess arrayRead(i:Int):ShaderDataType{
		return items[i];
		//return data[i*itemSize];
	}

	@:arrayAccess arrayWrite(i:Int, v:ShaderDataType):ShaderDataType{
		
	}
};

//wraps shader array, for _shader independant_ data
//needs to be able to handle enable and disable?
class ShaderBufferPointer implements ShaderDataType{
	var data:ShaderArray;

	var itemSize:Int;
	var type:Int;//Float, Int

	var normalized:Bool;//false, needs review
	var stride:Int;//usually 0
	var offset:Int;//usually 0

	var usage:Int;//when buffer is uploaded with GL.bufferData

	var buffer:GLBuffer;//buffer reference

	public function upload(){
		GL.bindBuffer(GL.ARRAY_BUFFER);
		GL.bufferData();
	}
};





//tests
struct Light{
	Vec2 direction;
	Vec3 color;
};

uniform Vec4 color;
uniform Mat4 modelMatrix;
uniform Float amount;
uniform Mat3 matrices[5];
uniform Light lights[8];

attribute vec3 position;

//...

var verticesObject:Buffer = {
	var data:Array<Vec3>;
	var buffer:GLBuffer;
	public function upload();
}

//

var shader = new Shader(vert, frag);

//possible initialization
shader.uniforms = [
	'color'       => new Color(),
	'modelMatrix' => new Mat4(),
	'amount'      => 3.14,
	'matrices'    => new Array<Mat3>(),
	'lights'	  => new Array<{
		var direction:Vec2;
		var color:Color;
	}>();
];

shader.attributes = [
	'position'    => verticesObject,
];


var themeColor = new Color(1.0, 0, 0);

shader['color'] = themeColor;
//...
themeColor.g = 0.5;//@! changed not flagged

shader['color'].b = 1.0;

shader['amount'] = 5;
shader['modelMatrix'] = Box.worldMatrix;//changes to worlMatrix not flagged


var headlight = {
	direction: new Vec2(1, 0),
	color: new Color(1,1,1)
};

shader['lights'][0] = headlight;

headlight.direction.y = 1;//change not flagged


/*
Issues
- when set from math object, if original math object changed, change is not flagged
- converting Array<...> to flat typed array
- structs

Solutions
- Write math classes to be observable by default
- Check for changes by searching the array (expensive?)
- Push everything anyway because uniforms are usually going to change when we render multiple objects with different properties and the same shader
	- then later try checking change before push to determine if js overhead worth it
- Choose a more primitive design for Shader class

Shader requirements:
- Easy compile and activate
- Automatically track uniform locations
- Easily update uniforms
- Easily update attributes
- Texture handling

*/

//complex vertex shader
struct Light{
	Vec2 direction;
	Vec3 color;
};

uniform Mat4 modelMatrix;
uniform Vec4 objColor;
uniform Float amount;
uniform Mat3 matrices[5];
uniform Light lights[8];

attribute vec3 position;
//---------------------

var illuminationShader = new Shader(vert, frag);

illuminationShader.addUniform('color', ShaderTypes.Vec2);

var sphere = new Mesh(new SphereGeometry(), shader);
illuminationShader['color'].set(1.0, 0.0, 0.0);

render();{
	GL.useProgram(illuminationShader.program);
}

//make sphere blue
illuminationShader['color'].set(0.0, 0.0, 1.0);

render();

/*
Issue
- I want sphere color to be a property of the sphere's material, not the shader, which will be reused on other objects
- we're not making use of Color class

Idea
- Material class that references shader and contains properties
- Shader automatically uploads all uniforms each frame, unless specially marked as manual upload
- Shader classes?
*/

//complex vertex shader
struct SubStruct{
	float damn;
}
struct Light{
	Vec2 direction;
	Vec3 color;
	SubStruct damn;
};

uniform Mat4 modelMatrix;
uniform Vec4 objColor;
uniform Float amount;
uniform Mat3 matrices[5];
uniform Light lights[8];

attribute vec3 position;
//---------------------

//Shader class
//A shader contains a program object and a table of each uniform with its location
//A shader does not contain any uniform data, nor any information on uploading it
//? maybe a shader contains details about uniform/attribute types for constructing materials

//ShaderMaterial
//A shader material contains typed uniform and attribute data
//? What about reference to the shader?
//? Can the same shader material be used with multiple shaders?

class ShaderMaterial{
	//a collection of properties for a shader
	//should be able to construct from a shader?
	//what if instead of a material, we just have uniform and attribute maps?
	var shader:Shader;
}

class ShaderData{//instead?

}


var illuminationShader = new Shader(vert, frag);
illuminationShader.addUniform('modelMatrix', ShaderTypes.Mat4);
illuminationShader.addUniform('objColor', ShaderTypes.Vec2);
illuminationShader.addUniform('amount', ShaderTypes.Float);
illuminationShader.addUniform('matrices', ShaderTypes.Array<Mat3>);
illuminationShader.addUniform('lights', ShaderTypes.Array<ShaderTypes.Struct<Light>>);

illuminationShader.addAttribute('position', ShaderTypes.Vec3);//@! can be vec3 buffer or vec3!

//or

//maybe use macro to easily add class properties
class IlluminationShader extends Shader{
	public function new(){
		super(vert, frag);
		this.uniformDefinitions = [
			'modelMatrix' => ShaderTypes.Mat4
			'objColor'    => ShaderTypes.Vec3
			'amount'      => ShaderTypes.Float
			'matrices'    => ShaderTypes.Array<Mat3>
			'lights'      => ShaderTypes.Array<ShaderTypes.Struct<Light>>
		];
		this.attributeDefinitions = [
			'position' => ShaderTypes.Vec3
		];
	}	
}

var illuminationShader = new IlluminationShader();

var sphere1 = new Mesh(new SphereGeometry(), new ShaderMaterial(illuminationShader));
var sphere2 = new Mesh(new SphereGeometry(), new ShaderMaterial(illuminationShader));
var light = new Light();

sphere1.material.['objColor'] = new Color(1.0, 0.0, 0.0);
sphere1.material['lights'][0] = light;

sphere2.material.['objColor'] = new Color(0.0, 0.0, 1.0);
sphere2.material['lights'][0] = light;

init();{
	illuminationShader.compile(){
		//compile
		//get uniform locations
		//get attribute locations
	};
}

render();{
	//grouped by shader
	var shader = sphere1.material.shader;
	GL.useProgram(shader);
	//render sphere 1
	for each sphere{

		for(u in sphere.material.uniforms){
			var name;
			var value;
			//@! maybe simple object check to see if the same object has been uploaded _within this frame_
			//ie, u == previous u
			u.uploadAsUniform();//how to cache?
		}

		for(a in sphere.material.attributes){
			var name;
			var value;
			a.uploadAsAttribute();
		}

	}
	//draw
}

//make sphere1 green
sphere1.material['objColor'].set(0,1,0);

render();

/*
Issues
-how to pass haxe math and typedefs to glsl types efficiently
*/


























//@! make sure this works for subclasses of CShader
abstract Shader(CShader) from CShader{
	@:to toGLProgram():GLProgram{
		return this.program;
	}

	@:arrayAccess arrayRead(s:String):ShaderDataType{
		var u = this.uniforms[s];
		return u != null ? u : this.attributes[s];
	}

	@:arrayAccess arrayWrite(s:String):ShaderDataType{
		//@!
	}
}

class CShader{

	public var uniforms:Map<String, Uniform>;
	public var attributes:Map<String, Attribute>;
	public var program:GLProgram;

	public var vertexGLSL(default, null):String;
	public var fragmentGLSL(default, null):String;

	public function new(vertexGLSL:String, fragmentGLSL:String, ?uniforms:Map<String, Uniform>, ?attributes:Map<String, Attribute>){
		throw 'todo';
		this.vertexGLSL = vertexGLSL;
		this.fragmentGLSL = fragmentGLSL;

		
		this.uniforms = uniforms != null ? uniforms : new Map<String, Uniform>();
		this.attributes = attributes != null ? attributes : new Map<String, Attribute>();
	}

	public function compile(){
		//@!
	}

	public function sync(){ //@! name ?
		//@! how to get attribute locations

		//should this be here?
		for(u in uniforms){
			if(u.needsUpload){
				u.upload();
			}
		}

		for(a in attributes){
			if(a.needsUpload){
				a.upload();
			}
		}
	}

	public function dispose():CShader{
		//@!
	}

}
