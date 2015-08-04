import snow.system.window.Window;
import snow.types.Types.AppConfig;
import snow.types.Types.ModState;
import snow.types.Types.Key;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.gl.GLProgram;
import gltoolbox.GLTools;
import gltoolbox.math.Color;

class Main extends snow.App {
	//snow boot
	override function config( config:AppConfig ):AppConfig{
		config.window.title = 'GLToolbox Scene Graph Test';
		config.render.antialiasing = 0;
		return config;
	}

	override function ready(){
		init();
		app.window.onrender = render;
	}

	override function update(dt:Float){

	}

	//app code
	var clearColor:Color;
	var triangleBuffer:GLBuffer;
	var program:GLProgram;
	var programData:{
		var aPosition:Int;
	};

	function init(){
		clearColor = new Color();

		//gl settings
		GL.clearColor(clearColor.r, clearColor.g, clearColor.b, 1.0);
		GL.disable(GL.CULL_FACE);

		//upload geometry
		var triangleVertices = [
			 0.0,  1.0,
			-1.0, -1.0,
			 1.0, -1.0
		];

		triangleBuffer = GLTools.uploadVertices(triangleVertices);

		//create triangle gpu program
		var geometryShaderSrc = 
		#if !desktop
		'precision mediump float;' +
		#end
		'
			attribute vec2 position;
			varying vec2 uv;
			void main(){
				uv = position*.5 + .5;
				gl_Position = vec4(position, 0.0, 1.0);
			}
		';
		var pixelShaderSrc = 
		#if !desktop
		'precision mediump float;' +
		#end
		'
			varying vec2 uv;
			void main(){
				gl_FragColor = vec4(uv, 0.0, 1.0);
			}
		';

		program = GLTools.uploadShaders(geometryShaderSrc, pixelShaderSrc);

		programData = {
			aPosition: GL.getAttribLocation(program, 'position')
		};
	}

	function render(window:Window){
		GL.viewport(0, 0, window.width, window.height);

		GL.clear(GL.COLOR_BUFFER_BIT);

		GL.useProgram(program);
		GL.bindBuffer(GL.ARRAY_BUFFER, triangleBuffer);

		GL.vertexAttribPointer(programData.aPosition, 2, GL.FLOAT, false, 0, 0);
		GL.enableVertexAttribArray(programData.aPosition);

		GL.drawArrays(GL.TRIANGLES, 0, 3);
	}

}
