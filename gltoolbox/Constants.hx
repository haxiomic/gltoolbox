//Texture

@:enum
abstract Targets(Int) to Int from Int{
	var TEXTURE_2D                  = GL.TEXTURE_2D;
	var TEXTURE_CUBE_MAP            = GL.TEXTURE_CUBE_MAP;

	var TEXTURE_CUBE_MAP_POSITIVE_X = GL.TEXTURE_CUBE_MAP_POSITIVE_X;
	var TEXTURE_CUBE_MAP_NEGATIVE_X = GL.TEXTURE_CUBE_MAP_NEGATIVE_X;
	var TEXTURE_CUBE_MAP_POSITIVE_Y = GL.TEXTURE_CUBE_MAP_POSITIVE_Y;
	var TEXTURE_CUBE_MAP_NEGATIVE_Y = GL.TEXTURE_CUBE_MAP_NEGATIVE_Y;
	var TEXTURE_CUBE_MAP_POSITIVE_Z = GL.TEXTURE_CUBE_MAP_POSITIVE_Z;
	var TEXTURE_CUBE_MAP_NEGATIVE_Z = GL.TEXTURE_CUBE_MAP_NEGATIVE_Z;
}

@:enum
abstract DataTypes(Int) to Int from Int{
	var BYTE                        = GL.BYTE;
	var UNSIGNED_BYTE               = GL.UNSIGNED_BYTE;
	var SHORT                       = GL.SHORT;
	var UNSIGNED_SHORT              = GL.UNSIGNED_SHORT;
	var INT                         = GL.INT;
	var UNSIGNED_INT                = GL.UNSIGNED_INT;
	var FLOAT                       = GL.FLOAT;
	var UNSIGNED_SHORT_4_4_4_4      = GL.UNSIGNED_SHORT_4_4_4_4;
	var UNSIGNED_SHORT_5_5_5_1      = GL.UNSIGNED_SHORT_5_5_5_1;
	var UNSIGNED_SHORT_5_6_5        = GL.UNSIGNED_SHORT_5_6_5;
}

@:enum
abstract MinFilters(Int) to Int from Int{
	var NEAREST_MIPMAP_NEAREST      = GL.NEAREST_MIPMAP_NEAREST;
	var LINEAR_MIPMAP_NEAREST       = GL.LINEAR_MIPMAP_NEAREST;
	var NEAREST_MIPMAP_LINEAR       = GL.NEAREST_MIPMAP_LINEAR;
	var LINEAR_MIPMAP_LINEAR        = GL.LINEAR_MIPMAP_LINEAR;
}

@:enum
abstract MagFilters(Int) to Int from Int{
	var NEAREST                     = GL.NEAREST;
	var LINEAR                      = GL.LINEAR;
}

@:enum
abstract Formats(Int) to Int from Int{
	var DEPTH_COMPONENT             = GL.DEPTH_COMPONENT;
	var ALPHA                       = GL.ALPHA;
	var RGB                         = GL.RGB;
	var RGBA                        = GL.RGBA;
	var LUMINANCE                   = GL.LUMINANCE;
	var LUMINANCE_ALPHA             = GL.LUMINANCE_ALPHA;
}

@:enum
abstract WrapModes(Int) to Int from Int{
	var REPEAT                      = GL.REPEAT;
	var CLAMP_TO_EDGE               = GL.CLAMP_TO_EDGE;
	var MIRRORED_REPEAT             = GL.MIRRORED_REPEAT;
}