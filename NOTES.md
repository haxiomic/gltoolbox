#Dev Notes

## Misc Unresolved
	- Consistent GPU push API, for geometry it's .upload, what about for textures? .glPush?, .glFlush?
		- .sync()? .glSync() which handles upload?
	- Head towards GPUToolbox instead of GLToolbox?
	- Chainability should be present everywhere
	- .clone() should be available in all objects
	- How to distinguish between attribute and attribute data and same for uniforms (ie, what type should be on Shader and what type on geometry). enum AttributeType? enum AttributeData?
	- How to implement blending?
	- Passing 2D vertices to vec3 position should work
	- Support for dynamic attribute data. See BufferAttributeData

## Math
	- Review Euler swappedIdx() gives the correct behavior
		Potentially need to fix other algorithms that involve Eulers
	- Remove inlines where unneeded
	- Mat3 2d transformation functions?
	- Some method of getting Euler angles from matrix, and use them for setRotationEuler defaults
		http://staff.city.ac.uk/~sbbh653/publications/euler.pdf
	- Orientation conversions
		- maybe this should be handled on the objects so convesions can be done without creating new objects
	- Color, from string (css style), from int

## Textures
	- Simple texture class that stores texture parameters along with GLTexture
	- offers .resize() [with optional resampling?]

## Shaders
	- Minimalistic, contains .attributes and .uniforms
		For example, shader might have 'position' attribute of type FVec2
	- enforce 0 attrib location for position
		GL.bindAttribLocation(programObject.program, 0, 'position');

## Geometry
	- Do we really need Geometry2D and 3D
		- for switching to determine how to render
	- How to support uvs, indices, normals, colors, tangents?
	- Need GeometryUtils .merge

## Render
	- rename render?
	- texture.clone() instead of texture factory

## Objects
	- Type switching on children with enum wrap!
	- **Mesh** should accept any Geometry (2D or 3D) and offers 3D transformations
	- Do we need a 2D version of Mesh? Perhaps **Sprite** which offers a 2D interface over **Mesh**. Rotation alters rotation in screen space
	- Camera

## GLTools
	- GL settings/setup (handles)
	- iOS half float issue


#Resolved Ideas
	- Observable Vectors?
		-> NO, keep with abstract vectors and design api to enforce observability elsewhere

------------------

Object
	- Scene graph functions
	- array of children
	- add/remove child functions

	Object3D
		- Position
		- Scale and Skew transformations

		Mesh
			- Mesh buffer
			- Material

Material/Substance
	- Shaders
	- Side?
	- Blending?