package gltoolbox.gl;

#if snow
import sys.io.File;now
typedef GLRenderbuffer = snow.modules.opengl.GL.GLRenderbuffer;
#elseif lime
typedef GLRenderbuffer = lime.graphics.opengl.GLRenderbuffer;
#elseif nme
typedef GLRenderbuffer = nme.gl.GLRenderbuffer;
#elseif hxsdl
typedef GLRenderbuffer = sdl.GL.Renderbuffer;
#elseif js
typedef GLRenderbuffer = js.html.webgl.Renderbuffer;
#end