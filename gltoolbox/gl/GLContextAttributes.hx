package gltoolbox.gl;

#if snow
typedef GLContextAttributes = snow.modules.opengl.GL.GLContextAttributes;
#elseif lime
typedef GLContextAttributes = lime.graphics.opengl.GLContextAttributes;
#elseif nme
typedef GLContextAttributes = nme.gl.GLContextAttributes;
#elseif hxsdl
typedef GLContextAttributes = sdl.GL.ContextAttributes;
#elseif js
typedef GLContextAttributes = js.html.webgl.ContextAttributes;
#end