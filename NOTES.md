#NOTES

## Unresolved
	- .clone() should be available in all objects
	- Consistent GPU push API, for geometry it's .upload, what about for textures? .glPush?, .glFlush?
	- How to distinguish between attribute and attribute data and same for uniforms (ie, what type should be on Shader and what type on geometry). enum AttributeType? enum AttributeData?
	- How to implement blending?
	- Passing 2D vertices to vec3 position should work

## Ideals:
	- Need to distinguish between buffers and objects

## Textures
	- Simple texture class that stores texture parameters along with GLTexture
	- offers .resize() [with optional resampling?]

## Shaders
	- Minimalistic, contains .attributes and .uniforms
	For example, shader might have 'position' attribute of type FVec2

## Geometry
	- How to support uvs, indices, normals, colors, tangents?
	- Need GeometryUtils .merge

## Render
	- texture.clone() instead of texture factory

## Objects
	- Local and world matrix transforms
	- Add/remove()
	- **Mesh** should accept any Geometry (2D or 3D) and offers 3D transformations
	- Do we need a 2D version of Mesh? Perhaps **Sprite** which offers a 2D interface over **Mesh**

## GLTools
	- GL settings


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