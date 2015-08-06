import gltoolbox.core.BufferAttribute;
import snow.system.window.Window;
import snow.types.Types.AppConfig;
import snow.types.Types.ModState;
import snow.types.Types.Key;

import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.gl.GLProgram;
import gltoolbox.gl.GLUniformLocation;
import gltoolbox.GLTools;
import gltoolbox.math.Color;
import gltoolbox.geometry.Geometry;
import gltoolbox.geometry.Geometry2D;
import gltoolbox.geometry.RegularPolygon;

typedef TmpProgramObject = {
	var program:GLProgram;
	var attributeLocations:Map<String, Int>;
	var uniformLocations:Map<String, GLUniformLocation>;
}

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

	override function update(dt:Float){}

	//app code
	var clearColor:Color;
	var triangleBuffer:GLBuffer;
	var programObject:TmpProgramObject;

	var geomA:Geometry2D;
	var geomB:Geometry2D;

	function init(){
		clearColor = new Color(0, 0, 0);

		//gl settings
		GL.clearColor(clearColor.r, clearColor.g, clearColor.b, 1.0);
		GL.disable(GL.CULL_FACE);

		//create and upload geometry
		geomA = new RegularPolygon(4, 0.5, Math.PI * 0.25, -0.5);
		geomA.upload();

		geomB = new RegularPolygon(10, 0.5);
		geomB.upload();

		//create gpu program
		var geometryShaderSrc = 
		#if !desktop
		'precision mediump float;' +
		#end
		'
			attribute vec2 position;
			varying vec2 p;
			void main(){
				p = position*.5 + .5;
				gl_Position = vec4(position, 0.0, 1.0);
			}
		';
		var pixelShaderSrc = 
		#if !desktop
		'precision mediump float;' +
		#end
		'
			varying vec2 p;
			void main(){
				gl_FragColor = vec4(p, 0.0, 1.0);
			}
		';

		programObject = {
			program: GLTools.uploadShaders(geometryShaderSrc, pixelShaderSrc),
			attributeLocations: new Map<String, Int>(),
			uniformLocations: new Map<String, GLUniformLocation>()
		}

		//enforce 0 attrib location for position
		GL.bindAttribLocation(programObject.program, 0, 'position');

		programObject.attributeLocations['position'] = GL.getAttribLocation(programObject.program, 'position');

		//enable attributes
		for(loc in programObject.attributeLocations){
			GL.enableVertexAttribArray(loc);
		}
	}

	function render(window:Window){
		GL.viewport(0, 0, window.width, window.height);

		GL.clear(GL.COLOR_BUFFER_BIT);

		var currentProgram:GLProgram;

		inline function draw(geom:Geometry, programObject:TmpProgramObject){
			if(programObject.program != currentProgram){
				GL.useProgram(programObject.program);
				currentProgram = programObject.program;
			}

			//link attributes to arrays
			for(name in programObject.attributeLocations.keys()){
				var attr = geom.attributes[name];
				if(attr == null) continue;

				//is it a buffer attribute?
				if(Reflect.hasField(attr, 'buffer')){
					var bufferAttr:BufferAttribute<Dynamic> = cast attr;
					GL.bindBuffer(GL.ARRAY_BUFFER, bufferAttr.buffer);
					GL.vertexAttribPointer(programObject.attributeLocations[name], bufferAttr.itemSize, GL.FLOAT, false, 0, 0);
				}

			}

			GL.drawArrays(geom.drawMode, 0, geom.vertexCount);
		}

		draw(geomA, programObject);
		draw(geomB, programObject);
	}

}
