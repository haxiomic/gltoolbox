#TODO

! Need to distinguish between buffers and objects

Textures
- Perhaps a texture object should exist that contains the texture buffer
	-> do away with TextureFactory

RenderTarget
- Rather than using a texture factory, some sort of texture object should be used, we can then generate new texture from properties

Resample needs a rework and support for upsampling


gltooblox.geometry

	## Option 1
	What if vertex functions are just static functions of geometry classes

	var sphere = new geometry.Sphere();
	var quadVerticies = geometry.Quad.rectangleVertices(...);
	var cubeNormals = geometry.Cube.normals(...)

	Do we still want to have a VertexData class to know number of vertices for example?

	---------

	## Options 2

	contains things like Sphere and Cube, as well as vertex, normals and w/e else generators?

		var sphere = new geometry.Sphere();
		var rectVertices = geometry.data.QuadData.rectangle();

!Consider VertexData class

Sync up render classes

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