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
*/

class Shader{
	
	public var glProgram;

	public function new(){
		//@!
	}

	//Shader Tools
	public function compileShaders(geometryShaderSrc:String, pixelShaderSrc:String):GLProgram{
		var geometryShader = GL.createShader(GL.VERTEX_SHADER);
		GL.shaderSource(geometryShader, geometryShaderSrc);
		GL.compileShader(geometryShader);

		//check for compilation errors
		if(GL.getShaderParameter(geometryShader, GL.COMPILE_STATUS) == 0){
			GL.deleteShader(geometryShader);
			throw 'Geometry shader error: '+GL.getShaderInfoLog(geometryShader);
		}

		var pixelShader = GL.createShader(GL.FRAGMENT_SHADER);
		GL.shaderSource(pixelShader, pixelShaderSrc);
		GL.compileShader(pixelShader);

		//check for compilation errors
		if(GL.getShaderParameter(pixelShader, GL.COMPILE_STATUS) == 0){
			GL.deleteShader(pixelShader);
			throw 'Pixel shader error: '+GL.getShaderInfoLog(pixelShader);
		}

		var program = GL.createProgram();
		GL.attachShader(program, geometryShader);
		GL.attachShader(program, pixelShader);
		GL.linkProgram(program);

		if(GL.getProgramParameter(program, GL.LINK_STATUS) == 0){
			GL.detachShader(program, geometryShader);
			GL.detachShader(program, pixelShader);
			GL.deleteShader(geometryShader);
			GL.deleteShader(pixelShader);
			throw GL.getProgramInfoLog(program);
		}

		return program;
	}

	public function dispose(){
		//@!
	}

}