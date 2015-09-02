package nucleus.gl;

#if snow
typedef GLTexture = snow.modules.opengl.GL.GLTexture;
#elseif lime
typedef GLTexture = lime.graphics.opengl.GLTexture;
#elseif nme
typedef GLTexture = nme.gl.GLTexture;
#elseif hxsdl
typedef GLTexture = sdl.GL.Texture;
#elseif js
typedef GLTexture = js.html.webgl.Texture;
#else
typedef GLTexture = Dynamic;
#end