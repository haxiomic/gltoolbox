#TODO

! Need to distinguish between buffers and objects

Textures
- Perhaps a texture object should exist that contains the texture buffer
	-> do away with TextureFactory

RenderTarget
- Rather than using a texture factory, some sort of texture object should be used, we can then generate new texture from properties

Resample needs a rework and support for upsampling

gltooblox.geometry

	Geometry2D Rectangle and a general-usage rectangle class?
	One for GPU use and the other for AABB?


	should we have a vertices class?

	new Vertices([
		0.0, 0.0,
		1.0, 1.0,
		2.0, 2.0
	], 2);

	What about a triangles class?

	Need to distinguish between vertices used for abstract representation of a geometry and vertices sent to the GPU

	Cube has vertices, normals, uvs, indices, maybe tangents, colors

	abstract Triangles(Float32Array){

	}

	Geometry2D and Geometry3D?
	what's the difference?
		Geometry3D has normals and others
		What if you don't want normals?

	should knowlege of dimensions be stored within the renderer or within Triangles?

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