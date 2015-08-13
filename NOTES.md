#Dev Notes

## Misc Unresolved
	- Rename GLTools to GPUInterface, try to be non-gl specific in naming?
	- .gpuObjects to store gpu references seperatly from other properties?
	- Need to distinguish between buffers and objects
	- Chainability should be present everywhere
	- .clone() should be available in all objects
	- Consistent GPU push API, for geometry it's .upload, what about for textures? .glPush?, .glFlush?
	- How to distinguish between attribute and attribute data and same for uniforms (ie, what type should be on Shader and what type on geometry). enum AttributeType? enum AttributeData?
	- How to implement blending?
	- Passing 2D vertices to vec3 position should work

## Math
	- Mat4, transformation matrix functions
		- .xyz and .scaleX, .scaleY, .scaleZ?
	- Quat
	- fromArray convenience (Array<Float>)

## Textures
	- Simple texture class that stores texture parameters along with GLTexture
	- offers .resize() [with optional resampling?]

## Shaders
	- Minimalistic, contains .attributes and .uniforms
	For example, shader might have 'position' attribute of type FVec2

## Geometry
	- Do we really need Geometry2D and 3D
		- for switching to determine how to render
	- How to support uvs, indices, normals, colors, tangents?
	- Need GeometryUtils .merge
	- Need quaternion

## Render
	- texture.clone() instead of texture factory

## Objects
	- Local and world matrix transforms
	- Add/remove()
	- **Mesh** should accept any Geometry (2D or 3D) and offers 3D transformations
	- Do we need a 2D version of Mesh? Perhaps **Sprite** which offers a 2D interface over **Mesh**. Rotation alters rotation in screen space
	- Camera

## GLTools
	- GL settings


#Resolved Points
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