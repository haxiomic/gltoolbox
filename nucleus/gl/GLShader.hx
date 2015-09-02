package nucleus.gl;

#if snow
typedef GLShader = snow.modules.opengl.GL.GLShader;
#elseif lime
typedef GLShader = lime.graphics.opengl.GLShader;
#elseif nme
typedef GLShader = nme.gl.GLShader;
#elseif hxsdl
typedef GLShader = sdl.GL.Shader;
#elseif js
typedef GLShader = js.html.webgl.Shader;
#else
typedef GLShader = Dynamic;
#end