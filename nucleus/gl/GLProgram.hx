package nucleus.gl;

#if snow
typedef GLProgram = snow.modules.opengl.GL.GLProgram;
#elseif lime
typedef GLProgram = lime.graphics.opengl.GLProgram;
#elseif nme
typedef GLProgram = nme.gl.GLProgram;
#elseif hxsdl
typedef GLProgram = sdl.GL.Program;
#elseif js
typedef GLProgram = js.html.webgl.Program;
#else
typedef GLProgram = Dynamic;
#end