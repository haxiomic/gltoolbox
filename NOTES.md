#TODO

! Need to distinguish between buffers and objects

Geometry
- Caching should be handled by a flag to create() and automatic

Textures
- Texture tools should be split up and named something like buffer generation?
- Perhaps a texture object should exist that contains the texture buffer

Color class

Render targets clear color

Resample needs a rework and support for upsampling

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