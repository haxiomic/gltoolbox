package gltoolbox.render;

import lime.graphics.GLRenderContext;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLFramebuffer;
import lime.graphics.opengl.GLTexture;
import lime.graphics.opengl.GL;
import shaderblox.ShaderBase;

class RenderTarget2Phase implements ITargetable{
	var gl:GLRenderContext;
	public var width 			 (default, null):Int;
	public var height 			 (default, null):Int;
	public var writeFrameBufferObject (default, null):GLFramebuffer;
	public var writeToTexture         (default, null):GLTexture;
	public var readFrameBufferObject  (default, null):GLFramebuffer;
	public var readFromTexture        (default, null):GLTexture;

	var textureFactory:GLRenderContext->Int->Int->GLTexture;

	public inline function new(gl:GLRenderContext, textureFactory:GLRenderContext->Int->Int->GLTexture, width:Int, height:Int){
		this.gl = gl;
		this.width = width;
		this.height = height;
		this.textureFactory = textureFactory;

		if(textureQuad == null)
			textureQuad = gltoolbox.GeometryTools.getCachedTextureQuad(gl, gl.TRIANGLE_STRIP);

		this.writeFrameBufferObject = gl.createFramebuffer();
		this.readFrameBufferObject  = gl.createFramebuffer();

		resize(width, height);
	}

	public function resize(width:Int, height:Int):ITargetable{
		var newWriteToTexture  = textureFactory(gl, width, height);
		var newReadFromTexture = textureFactory(gl, width, height);

		//attach texture to frame buffer object's color component
		gl.bindFramebuffer(gl.FRAMEBUFFER, this.writeFrameBufferObject);
		gl.framebufferTexture2D(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0, gl.TEXTURE_2D, newWriteToTexture, 0);

		//attach texture to frame buffer object's color component
		gl.bindFramebuffer(gl.FRAMEBUFFER, this.readFrameBufferObject);
		gl.framebufferTexture2D(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0, gl.TEXTURE_2D, newReadFromTexture, 0);

		if(this.readFromTexture != null){
			var resampler = gltoolbox.shaders.Resample.instance;
			resampler.texture.data = this.readFromTexture;

			gl.bindFramebuffer(gl.FRAMEBUFFER, readFrameBufferObject);
			gl.viewport(0, 0, width, height);

			gl.bindBuffer(gl.ARRAY_BUFFER, textureQuad);

			resampler.activate(true, true);
			gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
			resampler.deactivate();

			gl.deleteTexture(this.readFromTexture);
		}else clearRead();

		if(this.writeToTexture != null)
			gl.deleteTexture(this.writeToTexture);	
		else clearWrite();

		this.width = width;
		this.height = height;
		this.writeToTexture = newWriteToTexture;
		this.readFromTexture = newReadFromTexture;
		
		return this;
	}

	public inline function activate(){
		gl.bindFramebuffer(gl.FRAMEBUFFER, writeFrameBufferObject);
	}

	var tmpFBO:GLFramebuffer;
	var tmpTex:GLTexture;
	public inline function swap(){
		tmpFBO                 = writeFrameBufferObject;
		writeFrameBufferObject = readFrameBufferObject;
		readFrameBufferObject  = tmpFBO;

		tmpTex          = writeToTexture;
		writeToTexture  = readFromTexture;
		readFromTexture = tmpTex;
	}

	public inline function clear(mask:Int = GL.COLOR_BUFFER_BIT){
		clearRead(mask);
		clearWrite(mask);
	}

	public inline function clearRead(mask:Int = GL.COLOR_BUFFER_BIT){
		gl.bindFramebuffer(gl.FRAMEBUFFER, readFrameBufferObject);
		gl.clearColor (0, 0, 0, 1);
		gl.clear (mask);
	}

	public inline function clearWrite(mask:Int = GL.COLOR_BUFFER_BIT){
		gl.bindFramebuffer(gl.FRAMEBUFFER, writeFrameBufferObject);
		gl.clearColor (0, 0, 0, 1);
		gl.clear (mask);
	}

	public inline function dispose(){
		gl.deleteFramebuffer(writeFrameBufferObject);
		gl.deleteFramebuffer(readFrameBufferObject);
		gl.deleteTexture(writeToTexture);
		gl.deleteTexture(readFromTexture);
	}

	static var textureQuad:GLBuffer;
}

