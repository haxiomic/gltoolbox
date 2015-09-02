package nucleus.shader;

/*
var numUniforms = gl.getProgramParameter(program, gl.ACTIVE_UNIFORMS);
for(ii in 0..numUniforms){
	var uniformInfo = gl.getActiveUniform(program, ii);
	if (!uniformInfo) {
	  break;
	}
}

GLActiveInfo:{
	size:Int,
	type:Int,
	name:String
}


Interlacing:
	say we want to interlace position and uv
	
	vec3 pos;
	vec2 uv

	[p p p u u p p p u u ... ]
	position{
		offset = 0
		stride = sizeOf(position.type)*position.valuesPerElement + sizeOf(uv.type)*uv.valuesPerElement
	}
	uv{
		offset = sizeOf(position.type)*position.valuesPerElement
		stride = sizeOf(uv.type)*uv.valuesPerElement + sizeOf(position.type)*position.valuesPerElement
	}

Attributes:
	If it's helpful, we can set the attribute locations manually with
		bindAttribLocation
	but in this case you must link the shader AFTER those bindAttribLocation calls
*/

class Shader{
	
	public var glProgram;

	public function new(){
		//@!
	}

	public function initialize():Shader{
		compileShaders(vertexShader, fragmentShader);
		return this;
	}

	public function dispose(){
		//@!
	}

	private function compileShaders(vertexShaderSrc:String, fragmentShaderSrc:String):GLProgram{
		var vertexShader = GL.createShader(GL.VERTEX_SHADER);
		GL.shaderSource(vertexShader, vertexShaderSrc);
		GL.compileShader(vertexShader);

		//check for compilation errors
		if(GL.getShaderParameter(vertexShader, GL.COMPILE_STATUS) == 0){
			GL.deleteShader(vertexShader);
			throw 'vertex shader error: '+GL.getShaderInfoLog(vertexShader);
		}

		var fragmentShader = GL.createShader(GL.FRAGMENT_SHADER);
		GL.shaderSource(fragmentShader, fragmentShaderSrc);
		GL.compileShader(fragmentShader);

		//check for compilation errors
		if(GL.getShaderParameter(fragmentShader, GL.COMPILE_STATUS) == 0){
			GL.deleteShader(fragmentShader);
			throw 'fragment shader error: '+GL.getShaderInfoLog(fragmentShader);
		}

		var program = GL.createProgram();
		GL.attachShader(program, vertexShader);
		GL.attachShader(program, fragmentShader);
		GL.linkProgram(program);

		if(GL.getProgramParameter(program, GL.LINK_STATUS) == 0){
			GL.detachShader(program, vertexShader);
			GL.detachShader(program, fragmentShader);
			GL.deleteShader(vertexShader);
			GL.deleteShader(fragmentShader);
			throw GL.getProgramInfoLog(program);
		}

		return program;
	}

}