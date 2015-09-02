import nucleus.math.Vec2;
import nucleus.math.Vec3;
import nucleus.math.Color;
import nucleus.typedarray.Float32Array;
import nucleus.gl.GL;
import nucleus.GPU;

using ShaderHelper;

class Main{

	inline function new(){
		GL.clearColor(0,1,0,1);
		GL.clear(GL.COLOR_BUFFER_BIT);

		inline function rectArray(originX:Float, originY:Float, width:Float, height:Float){
			//GL.TRIANGLES
			return new Float32Array([
				originX,        originY+height, //top left
				originX,        originY,        //bottom left
				originX+width,  originY+height, //top right

				originX+width,  originY,        //bottom right
				originX+width,  originY+height, //top left
				originX,        originY         //bottom left
			]);
		}

		var vertices = rectArray(0, 0, 1, 1);

		var vertShader = "
			attribute vec2 position;
			void main(){
				gl_Position = vec4(position.xy, 0.0, 1.0);
			}
		";

		var fragShader = "
			void main(){
				gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
			}
		";

		var shaderProgram = GPU.compileShaders(vertShader, fragShader);
	}

	function render(time:Float){
	}

	static public inline function main(){
		//bootstrap
		#if js
		var document = js.Browser.document;
		document.body.style.padding = "0";
		document.body.style.margin = "0";

		var canvas = document.createCanvasElement();
		canvas.width = Std.int(js.Browser.window.innerWidth*.95);
		canvas.height = js.Browser.window.innerHeight;
		canvas.style.display = "block";
		canvas.style.margin = "0 auto";
		document.body.appendChild(canvas);
		GL.context = canvas.getContext('webgl');
		#end

		var m = new Main();

		function frameLoop(time:Float){
			m.render(time);
			#if js
			js.Browser.window.requestAnimationFrame(frameLoop);
			#end
		}

		#if js
		js.Browser.window.requestAnimationFrame(frameLoop);
		#end
	}

}