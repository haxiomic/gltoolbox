package nucleus.gl;

#if snow
typedef GLFramebuffer = snow.modules.opengl.GL.GLFramebuffer;
#elseif lime
typedef GLFramebuffer = lime.graphics.opengl.GLFramebuffer;
#elseif nme
typedef GLFramebuffer = nme.gl.GLFramebuffer;
#elseif hxsdl
typedef GLFramebuffer = sdl.GL.Framebuffer;
#elseif js
typedef GLFramebuffer = js.html.webgl.Framebuffer;
#else
typedef GLFramebuffer = Dynamic;
#end