import snow.system.window.Window;
import snow.types.Types.AppConfig;
import snow.types.Types.ModState;
import snow.types.Types.Key;

import gltoolbox.core.Attribute;
import gltoolbox.gl.GL;
import gltoolbox.gl.GLBuffer;
import gltoolbox.gl.GLProgram;
import gltoolbox.gl.GLUniformLocation;
import gltoolbox.GPU;
import gltoolbox.math.Color;
import gltoolbox.object.Object3D;
import gltoolbox.object.Mesh;
import gltoolbox.math.*;
import gltoolbox.geometry.Geometry;
import gltoolbox.geometry.Geometry2D;
import gltoolbox.geometry.RegularPolygonGeometry;
import gltoolbox.geometry.RectangleGeometry;

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
	override function update(dt:Float){
		mainLoop(dt);
	}
	
	//app code
	var timeStart:Float = 0;
	var clearColor:Color;
	var triangleBuffer:GLBuffer;
	var programObject:TmpProgramObject;

	var scene:Object3D;

	var mesh1:Mesh;
	var mesh2:Mesh;
	var mesh3:Mesh;

	function init(){
		timeStart = haxe.Timer.stamp();

		clearColor = new Color(0, 0, 0);

		//gl settings
		GL.clearColor(clearColor.r, clearColor.g, clearColor.b, 1.0);
		GL.disable(GL.CULL_FACE);

		//objects
		scene = new Object3D();

		mesh1 = new Mesh(new RectangleGeometry(-0.25, -0.25, 0.5, 0.5), null);
		mesh1.rotationZ = 0.2;

		mesh2 = new Mesh(new RegularPolygonGeometry(6, 0.25), null);
		mesh2.x = 0.3;

		mesh3 = new Mesh(new RegularPolygonGeometry(40, 0.1), null);
		mesh3.x = 0.2;

		mesh1.add(mesh2);
		mesh2.add(mesh3);

		var mesh4 = new Mesh(new RegularPolygonGeometry(6, 0.25), null);
		mesh4.x = -0.3;

		var mesh5 = new Mesh(new RegularPolygonGeometry(40, 0.1), null);
		mesh5.x = -0.2;

		mesh1.add(mesh4);
		mesh4.add(mesh5);

		scene.add(mesh1);

		//test mesh3 world decompose
		var p = new Vec3();
		var r = new Mat4();
		var s = new Vec3();
		mesh2.worldMatrix.decompose(p, r, s);
		trace(p);
		trace(r);
		trace(s);

		//create gpu program
		var geometryShaderSrc = 
		#if !desktop
		'precision mediump float;' +
		#end
		'
			attribute vec2 position;

			uniform mat4 modelMatrix;

			varying vec2 p;

			void main(){
				p = position*.5 + .5;
				gl_Position = modelMatrix * vec4(position, 0.0, 1.0);
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
			program: GPU.uploadShaders(geometryShaderSrc, pixelShaderSrc),
			attributeLocations: new Map<String, Int>(),
			uniformLocations: new Map<String, GLUniformLocation>()
		}

		//enforce 0 attrib location for position
		GL.bindAttribLocation(programObject.program, 0, 'position');

		inline function registerAttribute(name:String){
			programObject.attributeLocations[name] = GL.getAttribLocation(programObject.program, name);
		}
		inline function registerUniform(name:String){
			programObject.uniformLocations[name] = GL.getUniformLocation(programObject.program, name);
		}

		registerAttribute('position');
		registerUniform('modelMatrix');

		//enable attributes
		for(loc in programObject.attributeLocations){
			GL.enableVertexAttribArray(loc);
		}
	}

	inline function mainLoop(dt:Float){
		var time = (haxe.Timer.stamp() - timeStart);
		time = time * 0.5;

		mesh1.rotationX += 0.4*dt;
		mesh1.rotationY += 0.4*dt;
		mesh1.rotationZ += 0.4*dt;
		mesh1.scaleX = Math.sin(time)*0.8+1.0;
		mesh1.scaleY = Math.sin(time)*0.8+1.0;

		mesh2.y = Math.sin(time*3)*0.3;
		mesh3.x = Math.sin(time*3)*0.1 + 0.2;

	}


	var currentProgram:GLProgram;
	inline function render(window:Window){

		GL.viewport(0, 0, window.width, window.height);
		GL.clear(GL.COLOR_BUFFER_BIT);

		drawObject3D(scene);
	}

	//drawing functions
	function drawObject3D(object:Object3D){
		switch Type.getClass(object){
			case Mesh://@! doesn't handle mesh subclasses.
				drawMesh(untyped object);
		}

		for(c in object.children){
			drawObject3D(c);
		}
	}

	function drawMesh(mesh:Mesh){
		if(!mesh.visible) return;

		//bind mesh program
		//@! tmp program type
		if(programObject.program != currentProgram){
			GL.useProgram(programObject.program);
			currentProgram = programObject.program;
		}

		//pass transformation matrix as uniform
		GL.uniformMatrix4fv(programObject.uniformLocations['modelMatrix'], false, mesh.worldMatrix);

		var geom = mesh.geometry;

		//select GPU buffers for attributes
		for(name in programObject.attributeLocations.keys()){
			//get the geometry attribute that matches the program attribute
			var geoAttr = geom.attributes[name];
			if(geoAttr == null) continue;

			switch geoAttr{
				//buffer attribute
				case BufferAttribute(data):
					//upload to GPU if not already
					if(data.buffer == null){
						data.gpuUpload();
					}

					GL.bindBuffer(GL.ARRAY_BUFFER, data.buffer);
					GL.vertexAttribPointer(programObject.attributeLocations[name], data.itemSize, GL.FLOAT, false, 0, 0);
				default:
					throw 'Not implemented';
			}
		}

		GL.drawArrays(geom.drawMode, 0, geom.vertexCount);
	}

}
