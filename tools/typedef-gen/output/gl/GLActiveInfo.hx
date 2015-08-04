package gltoolbox.gl;

#if snow
import sys.io.File;now
typedef GLActiveInfo = snow.modules.opengl.GL.GLActiveInfo;
#elseif lime
typedef GLActiveInfo = lime.graphics.opengl.GLActiveInfo;
#elseif nme
typedef GLActiveInfo = nme.gl.GLActiveInfo;
#elseif hxsdl
typedef GLActiveInfo = sdl.GL.ActiveInfo;
#elseif js
typedef GLActiveInfo = js.html.webgl.ActiveInfo;
#end