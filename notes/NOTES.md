#Immediate Todo
- Shaders and Texture classes
- Indices UVs on Geometry (use drawElements)
- Shading on Mesh with new Shader/Program class
- Split core and renderer
- Complete RenderTarget and RenderTarget two pass

---

#Dev Notes

## Misc Unresolved
	- names
	#1	glNucleus
	#2	glCoreBox
	
		glFoundation
		glEssentials
		glCore
		glBackbone
		glEssence
		glCrux

	-	glNucleus //deals with just CPU wrappers for GPU objects
			gl
			math
			typedarray
			shader
				Shader
			texture
				Texture

			- Initially when objects are created, they don't require a context.
			- .dispose() everywhere?
			- upload() vs sync()
			- activate()?
			- isValid() everywhere? Null check for initialization is bad? 
				what about invalidate(), called on everything when context lost
			- Support for dynamic attribute data. See BufferAttributeData
			- Support for dynamic textures

		//renderbox
		object
			Object3D
			Mesh
		render //needs review
			Renderer
			RTT
		- .clone() should be available in all objects
		- chainability should be present everywhere
		- toString()s for all objects

	- Noteworthy extensions to consider
		var glExtensionTextureFloat = gl.getExtension( 'OES_texture_float' );
		var glExtensionTextureHalfFloat = gl.getExtension( 'OES_texture_half_float' );
		var glExtensionDebugRendererInfo = gl.getExtension( 'WEBGL_debug_renderer_info' );
		var glExtensionDrawBuffers = gl.getExtension( 'WEBGL_draw_buffers' );
		var glExtensionAnisotropic = gl.getExtension( 'EXT_texture_filter_anisotropic' ) || gl.getExtension('WEBKIT_EXT_texture_filter_anisotropic' );

	- All ints replaced with fake enums so it's clear what parameters a value can take
	- Active texture when allocating textures?
	- Remove unnecessary imports
	- How to distinguish between attribute and attribute data and same for uniforms (ie, what type should be on Shader and what type on geometry). enum AttributeType? enum AttributeData?
	- How to implement blending?
	- Passing 2D vertices to vec3 position should work

## Math
	- Review Euler swappedIdx() gives the correct behavior [i don't think it does.]
		Potentially need to fix other algorithms that involve Eulers
	- Some method of getting Euler angles from matrix, and use them for setRotationEuler defaults
		http://staff.city.ac.uk/~sbbh653/publications/euler.pdf
	- Color, from string (css style), from int

## Textures
	- Handle POT issues

## Shaders
	- CPU-side uniform objects? What about structs? Observable forms of math objects?
		- structs can be nested (refer to another struct within) to a level of 4
		- struct _definitions_ cannot be nested
	- Minimalistic, contains .attributes and .uniforms
		For example, shader might have 'position' attribute of type FVec2
	- enforce 0 attrib location for position
		GL.bindAttribLocation(programObject.program, 0, 'position');

## Geometry
	- Generators/Shapes, for generating array of vertices, uvs, normals
	- Do we really need Geometry2D and 3D
		- for switching to determine how to render
	- How to support uvs, indices, normals, colors, tangents?
	- Need GeometryUtils .merge

## Render
	- for RTT texture.clone() instead of texture factory - or construct new texture from properties

## Objects
	- **Mesh** should accept any Geometry (2D or 3D) and offers 3D transformations
	- Do we need a 2D version of Mesh? Perhaps **Sprite** which offers a 2D interface over **Mesh**. Rotation alters rotation in screen space
	- Camera

## GPU
	- GL settings/setup (handles)
	- iOS half float issue, looks like there's a HALF_FLOAT extension to look into


#Resolved Principles
	- Observable Vectors?
		-> NO, keep with abstract vectors and design api to enforce observability elsewhere
