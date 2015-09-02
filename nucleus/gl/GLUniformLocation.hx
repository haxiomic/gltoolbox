package nucleus.gl;

#if snow
typedef GLUniformLocation = snow.modules.opengl.GL.GLUniformLocation;
#elseif lime
typedef GLUniformLocation = lime.graphics.opengl.GLUniformLocation;
#elseif nme
typedef GLUniformLocation = nme.gl.GLUniformLocation;
#elseif hxsdl
typedef GLUniformLocation = sdl.GL.UniformLocation;
#elseif js
typedef GLUniformLocation = js.html.webgl.UniformLocation;
#else
typedef GLUniformLocation = Dynamic;
#end