package nucleus.gl;

#if snow
typedef GLActiveInfo = snow.modules.opengl.GL.GLActiveInfo;
#elseif lime
typedef GLActiveInfo = lime.graphics.opengl.GLActiveInfo;
#elseif nme
typedef GLActiveInfo = nme.gl.GLActiveInfo;
#elseif hxsdl
typedef GLActiveInfo = sdl.GL.ActiveInfo;
#elseif js
typedef GLActiveInfo = js.html.webgl.ActiveInfo;
#else
typedef GLActiveInfo = Dynamic;
#end