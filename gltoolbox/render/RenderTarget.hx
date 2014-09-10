package gltoolbox.render;

import lime.graphics.GLRenderContext;
import lime.graphics.opengl.GLBuffer;
import lime.graphics.opengl.GLFramebuffer;
import lime.graphics.opengl.GLTexture;
import lime.graphics.opengl.GL;
import shaderblox.ShaderBase;

class RenderTarget implements ITargetable{
	var gl:GLRenderContext;
	public var width 			 (default, null):Int;
	public var height 			 (default, null):Int;
	public var frameBufferObject (default, null):GLFramebuffer;
	public var texture           (default, null):GLTexture;

	var textureFactory:GLRenderContext->Int->Int->GLTexture;

	public inline function new(gl:GLRenderContext, textureFactory:GLRenderContext->Int->Int->GLTexture, width:Int, height:Int){
		this.gl = gl;
		this.width = width;
		this.height = height;
		this.textureFactory = textureFactory;
		this.texture = textureFactory(gl, width, height);

		if(textureQuad == null)
			textureQuad = gltoolbox.GeometryTools.getCachedTextureQuad(gl, gl.TRIANGLE_STRIP);

		this.frameBufferObject = gl.createFramebuffer();

		resize(width, height);
	}

	public inline function resize(width:Int, height:Int):ITargetable{
		var newTexture = textureFactory(gl, width, height);
		//attach texture to frame buffer object's color component	
		gl.bindFramebuffer(gl.FRAMEBUFFER, this.frameBufferObject);
		gl.framebufferTexture2D(gl.FRAMEBUFFER, gl.COLOR_ATTACHMENT0, gl.TEXTURE_2D, newTexture, 0);

		if(this.texture != null){
			var resampler = gltoolbox.shaders.Resample.instance;
			resampler.texture.data = this.texture;

			gl.bindFramebuffer(gl.FRAMEBUFFER, frameBufferObject);
			gl.viewport(0, 0, width, height);

			gl.bindBuffer(gl.ARRAY_BUFFER, textureQuad);

			resampler.activate(true, true);
			gl.drawArrays(gl.TRIANGLE_STRIP, 0, 4);
			resampler.deactivate();

			gl.deleteTexture(this.texture);
		}else clear();

		this.width = width;
		this.height = height;
		this.texture = newTexture;
	
		return this;
	}

	public inline function activate(){
		gl.bindFramebuffer(gl.FRAMEBUFFER, this.frameBufferObject);
	}

	public inline function clear(mask:Int = GL.COLOR_BUFFER_BIT){
		gl.bindFramebuffer(gl.FRAMEBUFFER, this.frameBufferObject);
		//clear white
		gl.clearColor (0, 0, 0, 1);
		gl.clear (mask);
	}

	public inline function dispose(){
		gl.deleteFramebuffer(frameBufferObject);
		gl.deleteTexture(texture);
	}

	static var textureQuad:GLBuffer;
}