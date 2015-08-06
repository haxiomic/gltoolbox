#TODO

! Need to distinguish between buffers and objects

Textures
- Perhaps a texture object should exist that contains the texture buffer
	-> do away with TextureFactory

RenderTarget
- Rather than using a texture factory, some sort of texture object should be used, we can then generate new texture from properties

Resample needs a rework and support for upsampling

gltooblox.geometry
	Cube has vertices, normals, uvs, indices, maybe tangents, colors

!Consider VertexData class

Render pipeline. Do we create a renderer or consciously not and leave it up to the user?

new Float32Array() is very slow. Make efforts to minimize vector creation!

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