import nucleus.buffer.Buffer;
import nucleus.math.Vec2;
import nucleus.math.Vec3;
import nucleus.math.RGB;
import nucleus.typedarray.Float32Array;
import nucleus.NU;

class Main{
	var testProgram:Shader;
	var vertices:Buffer;

	var color1:RGB = new RGB(0,1,0);
	var color2:RGB = new RGB(0,0,1);

	inline function new(){
		NU.clearColor(1,0,0,1);
		NU.clear(ClearBit.COLOR_BUFFER_BIT);

		inline function rectArray(originX:Float, originY:Float, width:Float, height:Float){
			//TRIANGLES
			return new Float32Array([
				originX,        originY+height, //top left
				originX,        originY,        //bottom left
				originX+width,  originY+height, //top right

				originX+width,  originY,        //bottom right
				originX+width,  originY+height, //top left
				originX,        originY         //bottom left
			]);
		}

		var attributesBuffer = new Buffer(rectArray(0,0,1,1), BufferUsage.STATIC_DRAW);
		vertices = new FormattedData(attributesBuffer, 2, 20, 0, false);
		uvs = new FormattedData(attributesBuffer, 2, 20, 12, false);

		//alt
		vertices = new FormattedBuffer(rectArray(0,0,1,1), 2);
		uvs = new FormattedBuffer([...], 2);

		indices = new Buffer(new UInt8Array([...]));

		var vertShader = "
			attribute vec2 position;
			void main(){
				gl_Position = vec4(position.xy, 0.0, 1.0);
			}
		";

		var fragShader = "
			uniform vec3 color;
			void main(){
				gl_FragColor = vec4(color, 1.0);
			}
		";

		// testProgram = new Shader(vertShader, fragShader);
	}

	function initialize(){
		vertices.initialize();
		uvs.initialize();
		indices.initialize();
		testProgram.initialize();
	}

	function render(time:Float){
		//aim

		NU.useProgram(testProgram);

		NU.setAttributeBuffer(testProgram.attributes['vertices'], vertices1:FormattedBuffer);{
			// GL.bindBuffer(GL.ARRAY_BUFFER, vertices1.buffer);
			Buffer.activate(uvs1.buffer);
			GL.vertexAttribPointer(testProgram.attributes['vertices'], vertices1.size, vertices1.type, vertices1.normalize, vertices1.stride, vertices1.offset);
		}

		NU.setAttributeBuffer(testProgram.attributes['uvs'], uvs1:FormattedBuffer);{
			//same buffer object!
			// GL.bindBuffer(GL.ARRAY_BUFFER, uvs1.buffer);
			Buffer.activate(uvs1.buffer);
			GL.vertexAttribPointer(testProgram.attributes['uvs'], uvs1.size, uvs1.type, uvs1.normalize, uvs1.stride, uvs1.offset);
		}

		NU.setUniformVec3(testProgram.uniforms['color'], color1);
		NU.setUniformTexture(testProgram.uniforms['texture'], texture){
			NU.assignTextureUnit(texture);
			GL.uniform1i(...);
		}

		NU.drawArrays(DrawModes.TRIANGLES, 0, vertices1.count);

		//alt
		NU.drawIndexed(indexBuffer, DrawModes.TRIANGLES, ?indexBuffer.length, ?IndicesType.UNSIGNED_SHORT, ?0);{
			GL.bindBuffer(GL.ELEMENT_ARRAY_BUFFER, indexBuffer);
			GL.drawElements(...);
		}

	}

	static public inline function main(){
		//bootstrap
		#if js
		var document = js.Browser.document;
		document.body.style.padding = "0";
		document.body.style.margin = "0";

		var canvas = document.createCanvasElement();
		canvas.width = js.Browser.window.innerWidth;
		canvas.height = js.Browser.window.innerHeight;
		canvas.style.display = "block";
		canvas.style.margin = "0 auto";
		document.body.appendChild(canvas);
		nucleus.gl.GL.context = canvas.getContext('webgl');
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