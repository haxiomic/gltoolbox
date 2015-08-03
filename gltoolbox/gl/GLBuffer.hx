package gltoolbox.gl;

#if snow
typedef GLBuffer = snow.modules.opengl.GL.GLBuffer;
#elseif lime
typedef GLBuffer = lime.graphics.opengl.GLBuffer;
#elseif nme
typedef GLBuffer = nme.gl.GLBuffer;
#elseif hxsdl
typedef GLBuffer = sdl.GL.Buffer;
#elseif js
typedef GLBuffer = js.html.webgl.Buffer;
#end