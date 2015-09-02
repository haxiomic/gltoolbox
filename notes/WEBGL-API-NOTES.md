/*
	Notes

	Framebuffer:
		- a collection of buffers (as attachments), like color buffer or depth buffer
		- each attachment can be either a texture or a Renderbuffer
	Renderbuffer:
		- essentially a texture with a fixed format that depends on the implementation
		- _cannot_ be used as a sampler in a shader (=no rtt)
		- useful for fast transfer operations
		- can store depth or stencil, not good for post processing
*/

//------------ Untouched in Nucleus ------------ //
//execution control - COMPLETE
finish():Void //block until all GL execution is complete
flush():Void //force execution of GL commands in finite time,  call glFlush before waiting for user input that depends on the generated image.

//settings -- COMPLETE
enable(cap:Int):Void
disable(cap:Int):Void
clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void
clearDepth(depth:Float):Void
clearStencil(s:Int):Void
cullFace(mode:Int):Void
frontFace(mode:Int):Void
hint(target:Int, mode:Int):Void
lineWidth(width:Float):Void
colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void //enable and disable writing of frame buffer color components
sampleCoverage(value:Float, invert:Bool):Void //for use when GL_SAMPLE_COVERAGE is enabled, gives some control over antialiasing
polygonOffset(factor:Float, units:Float):Void
//depth
depthFunc(func:Int):Void
depthMask(flag:Bool):Void
depthRange(zNear:Float, zFar:Float):Void
//stencil
stencilFunc(func:Int, ref:Int, mask:Int):Void
stencilFuncSeparate(face:Int, func:Int, ref:Int, mask:Int):Void
stencilMask(mask:Int):Void
stencilMaskSeparate(face:Int, mask:Int):Void
stencilOp(fail:Int, zfail:Int, zpass:Int):Void
stencilOpSeparate(face:Int, fail:Int, zfail:Int, zpass:Int):Void
pixelStorei(pname:Int, param:Int):Void //Sets pixel storage modes for readPixels and unpacking of textures with texImage2D and texSubImage2D .

//blending - COMPLETE
blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void
blendEquation(mode:Int):Void
blendEquationSeparate(modeRGB:Int, modeAlpha:Int):Void
blendFunc(sfactor:Int, dfactor:Int):Void
blendFuncSeparate(srcRGB:Int, dstRGB:Int, srcAlpha:Int, dstAlpha:Int):Void

//draw - COMPLETE
clear(mask:Int):Void
drawArrays(mode:Int, first:Int, count:Int):Void
drawElements(mode:Int, count:Int, type:Int, offset:Int):Void
viewport(x:Int, y:Int, width:Int, height:Int):Void
scissor(x:Int, y:Int, width:Int, height:Int):Void//It gives you the ability to constrain per-fragment ops to a rectangular portion of the screen, but without actually modifying the current viewport transform.

//query state - COMPLETE
// - global state
getParameter(pname:Int):Dynamic
getError():Int
getSupportedExtensions():Array<String>
getExtension(name:String):Dynamic
getContextAttributes():GLContextAttributes




//------------ Removed in Nucleus ------------ //
createBuffer():GLBuffer
createFramebuffer():GLFramebuffer 
createProgram():GLProgram
createRenderbuffer():GLRenderbuffer
createShader(type:Int):GLShader
createTexture():GLTexture

deleteBuffer(buffer:GLBuffer):Void
deleteFramebuffer(framebuffer:GLFramebuffer):Void
deleteProgram(program:GLProgram):Void
deleteRenderbuffer(renderbuffer:GLRenderbuffer):Void
deleteShader(shader:GLShader):Void
deleteTexture(texture:GLTexture):Void

isBuffer(buffer:GLBuffer):Bool
isEnabled(cap:Int):Bool
isFramebuffer(framebuffer:GLFramebuffer):Bool
isProgram(program:GLProgram):Bool
isRenderbuffer(renderbuffer:GLRenderbuffer):Bool
isShader(shader:GLShader):Bool
isTexture(texture:GLTexture):Bool

bindAttribLocation(program:GLProgram, index:Int, name:String):Void
bindBuffer(target:Int, buffer:GLBuffer):Void
bindFramebuffer(target:Int, framebuffer:GLFramebuffer):Void
bindRenderbuffer(target:Int, renderbuffer:GLRenderbuffer):Void
bindTexture(target:Int, texture:GLTexture):Void

//framebuffer
checkFramebufferStatus(target:Int):Int
framebufferRenderbuffer(target:Int, attachment:Int, renderbuffertarget:Int, renderbuffer:GLRenderbuffer):Void
framebufferTexture2D(target:Int, attachment:Int, textarget:Int, texture:GLTexture, level:Int):Void
readPixels(x:Int, y:Int, width:Int, height:Int, format:Int, type:Int, data:ArrayBufferView):Void

//renderbuffer
renderbufferStorage(target:Int, internalformat:Int, width:Int, height:Int):Void //create and initialize a renderbuffer object's data store

//buffer data
bufferData(target:Int, data:ArrayBufferView, usage:Int):Void
bufferSubData(target:Int, offset:Int, data:ArrayBufferView):Void

//texture
//-unresolved
compressedTexImage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, data:ArrayBufferView):Void
compressedTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, data:ArrayBufferView):Void
copyTexImage2D(target:Int, level:Int, internalformat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void
copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void
texImage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, data:ArrayBufferView):Void
texParameterf(target:Int, pname:Int, param:Float):Void
texParameteri(target:Int, pname:Int, param:Int):Void
texSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, data:ArrayBufferView):Void
generateMipmap(target:Int):Void
//-resolved
activeTexture(texture:Int):Void //sets active texture

//shader
useProgram(program:GLProgram):Void
attachShader(program:GLProgram, shader:GLShader):Void
compileShader(shader:GLShader):Void
detachShader(program:GLProgram, shader:GLShader):Void
linkProgram(program:GLProgram):Void
enableVertexAttribArray(index:Int):Void
disableVertexAttribArray(index:Int):Void
shaderSource(shader:GLShader, source:String):Void
validateProgram(program:GLProgram):Void

//shader data upload
//uniform
uniform1f(location:GLUniformLocation, x:Float):Void
uniform1fv(location:GLUniformLocation, data:Float32Array):Void
uniform1i(location:GLUniformLocation, x:Int):Void
uniform1iv(location:GLUniformLocation, data:Int32Array):Void
uniform2f(location:GLUniformLocation, x:Float, y:Float):Void
uniform2fv(location:GLUniformLocation, data:Float32Array):Void
uniform2i(location:GLUniformLocation, x:Int, y:Int):Void
uniform2iv(location:GLUniformLocation, data:Int32Array):Void
uniform3f(location:GLUniformLocation, x:Float, y:Float, z:Float):Void
uniform3fv(location:GLUniformLocation, data:Float32Array):Void
uniform3i(location:GLUniformLocation, x:Int, y:Int, z:Int):Void
uniform3iv(location:GLUniformLocation, data:Int32Array):Void
uniform4f(location:GLUniformLocation, x:Float, y:Float, z:Float, w:Float):Void
uniform4fv(location:GLUniformLocation, data:Float32Array):Void
uniform4i(location:GLUniformLocation, x:Int, y:Int, z:Int, w:Int):Void
uniform4iv(location:GLUniformLocation, data:Int32Array):Void
uniformMatrix2fv(location:GLUniformLocation, transpose:Bool, data:Float32Array):Void
uniformMatrix3fv(location:GLUniformLocation, transpose:Bool, data:Float32Array):Void
uniformMatrix4fv(location:GLUniformLocation, transpose:Bool, data:Float32Array):Void
//attribute
vertexAttrib1f(indx:Int, x:Float):Void
vertexAttrib1fv(indx:Int, data:Float32Array):Void
vertexAttrib2f(indx:Int, x:Float, y:Float):Void
vertexAttrib2fv(indx:Int, data:Float32Array):Void
vertexAttrib3f(indx:Int, x:Float, y:Float, z:Float):Void
vertexAttrib3fv(indx:Int, data:Float32Array):Void
vertexAttrib4f(indx:Int, x:Float, y:Float, z:Float, w:Float):Void
vertexAttrib4fv(indx:Int, data:Float32Array):Void
vertexAttribPointer(indx:Int, size:Int, type:Int, normalized:Bool, stride:Int, offset:Int):Void


//Query state
// - shader & program state
getShaderParameter(shader:GLShader, pname:Int):Int
getShaderPrecisionFormat(shadertype:Int, precisiontype:Int):GLShaderPrecisionFormat
getShaderSource(shader:GLShader):String
getShaderInfoLog(shader:GLShader):String
getProgramParameter(program:GLProgram, pname:Int):Int
getProgramInfoLog(program:GLProgram):String
getActiveAttrib(program:GLProgram, index:Int):GLActiveInfo
getActiveUniform(program:GLProgram, index:Int):GLActiveInfo
getAttachedShaders(program:GLProgram):Array<GLShader>
getAttribLocation(program:GLProgram, name:String):Int
getUniform(program:GLProgram, location:GLUniformLocation):Dynamic
getUniformLocation(program:GLProgram, name:String):GLUniformLocation
getVertexAttrib(index:Int, pname:Int):Dynamic
getVertexAttribOffset(index:Int, pname:Int):Int
// - texture state
getTexParameter(target:Int, pname:Int):Dynamic
// - buffer state
getBufferParameter(target:Int, pname:Int):Dynamic
// - framebuffer state
getFramebufferAttachmentParameter(target:Int, attachment:Int, pname:Int):Dynamic
// - renderbuffer state
getRenderbufferParameter(target:Int, pname:Int):Dynamic