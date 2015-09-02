# Best practices

## Handling context lost https://www.khronos.org/webgl/wiki/HandlingContextLost
		- we'll need to null unit on textures when context lost
		- events "webglcontextlost", "webglcontextrestored"
		- rendering loop should be turned off when context is lost but the event isn't fired straight away
			- context lost can occur during the rendering loop
			- I think it ignores gl commands until the next requestAnimationFrame?
			- onContextLost, cancelRequestAnimationFrame and then init gl state before enabling requestAnimationFrame again

		- Shaders: "Don’t check for NULL on creation"	
		"You should really only get null from these functions if the context is lost and in that case there’s no reason to check. WebGL is designed so that for the most part everything just runs as normal even when a program or shader is null."
		- need an easy way to setup state / upload resources
		- want to avoid checking in rendering loop; instead, assume everything is working until a fail like context lost
		- State is: textures, buffers, framebuffers, renderbuffers, shaders, programs, (clearColor, blendFunc, depthFunc, etc...)
		- Maybe gltoolbox shouldn't actually handle context lost, but instead make it very easy to be handled
			- could have some context handling business in gl/GL.hx?

	- getError() Never call in production! 
	- You should never use #ifdef GL_ES in your WebGL shaders; although some early examples used this, it's not necessary, since this condition is always true in WebGL shaders.
	- In general, only using highp in both vertex and fragment shaders is safer unless shaders are thoroughly tested on a variety of platforms. Starting in Firefox 11, the WebGL getShaderPrecisionFormat() function is implemented, allowing you to check if highp precision is supported, and more generally letting you query the actual precision of all supported precision qualifiers.
	- Starting in Firefox 10, the webgl.min_capability_mode preference allows simulating minimal values for these capabilities, to test portability.
	- usage of textures in vertex shaders is only possible if webgl.getParameter(webgl.MAX_VERTEX_TEXTURE_IMAGE_UNITS) is greater than zero. Typically, this fails on current mobile hardware.
	- Rendering to a floating-point texture may not be supported, even if the OES_texture_float extension is supported. Typically, this fails on current mobile hardware. To check if this is supported, you have to call the WebGL checkFramebufferStatus() function.

## Performance
	- see https://docs.google.com/presentation/d/12AGAUmElB0oOBgbEEBfhABkIMCL3CUX7kdAPLuwZ964/edit#slide=id.i148
	- Anything that requires syncing the CPU and GPU sides is potentially very slow, so if possible you should try to avoid doing that in your main rendering loops. This includes the following WebGL calls: getError(), readPixels(), and finish(). WebGL getter calls such as getParameter() and getUniformLocation() should be considered slow too, so try to cache their results in a JavaScript variable.
	- Always have vertex attrib 0 array enabled. If you draw with vertex attrib 0 array disabled, you will force the browser to do complicated emulation when running on desktop OpenGL (e.g. on Mac OSX). This is because in desktop OpenGL, nothing gets drawn if vertex attrib 0 is not array-enabled. You can use bindAttribLocation() to force a vertex attribute to use location 0, and use enableVertexAttribArray() to make it array-enabled.
	- Separate writes from reads by as many calls as possible
	- When drawing, objects should be grouped by state (shaders and uniforms?)
		In order of most important state to group by
			- framebuffer, blending, clipping, depth
			- program, buffer (.bindBuffer), texture
				- batch data in a single buffer where possible
			- uniforms
		Only sort when changed
	- If depth buffer enabled, we don't need sort by depth on the CPU
		- generally better to always have depth buffer for sorting
		- when using depth buffer, try to draw:
			Opaque objects in front-to-back order
			Translucent in back-to-front
			UI back-to-front with depth-test disabled (because UI tends to be drawn in correct order anyway)
	- If doing RTT on a scene, this requires a new depth buffer
	- GLSL
		- When sampling from a texture for date that's used to sample another, try to insert expensive math in between samples so the GPU is not idle
			- try to avoid this in the first place
	- Uploading data duirng a frame
		- do upload at the start of the frame, draw the uploaded data and the end (so draws can be executed during the upload)