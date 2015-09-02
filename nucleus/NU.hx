/*
	Nucleus

	Simplifying interface over OpenGL ES
	Designed to make use of the advantages haxe brings
*/

package nucleus;

import nucleus.gl.GL;
import nucleus.gl.GLBuffer;
import nucleus.gl.GLTexture;
import nucleus.gl.GLProgram;
import nucleus.gl.GLContextAttributes;
import nucleus.typedarray.Float32Array;
import nucleus.typedarray.ArrayBufferView;
import nucleus.math.RGBA;

class NU{

	static public var MAX_VERTEX_ATTRIBS(get, null):Null<Int>;
	static public var MAX_VARYING_VECTORS(get, null):Null<Int>;
	static public var MAX_VERTEX_UNIFORM_VECTORS(get, null):Null<Int>;
	static public var MAX_FRAGMENT_UNIFORM_VECTORS(get, null):Null<Int>;
	static public var MAX_TEXTURE_IMAGE_UNITS(get, null):Null<Int>;
	static public var MAX_VERTEX_TEXTURE_IMAGE_UNITS(get, null):Null<Int>;
	static public var MAX_COMBINED_TEXTURE_IMAGE_UNITS(get, null):Null<Int>;
	static public var MAX_TEXTURE_SIZE(get, null):Null<Int>;
	static public var MAX_CUBE_MAP_TEXTURE_SIZE(get, null):Null<Int>;
	static public var MAX_RENDERBUFFER_SIZE(get, null):Null<Int>;

	/* Settings & Global State */
	static public inline function enable(cap:Capability):Void
		GL.enable(cap);
	static public inline function disable(cap:Capability):Void
		GL.disable(cap);
	static public inline function cullFace(mode:FaceMode):Void
		GL.cullFace(mode);
	static public inline function frontFace(mode:FrontFaceMode):Void
		GL.frontFace(mode);
	static public inline function hint(target:HintTarget, mode:HintMode):Void
		GL.hint(target, mode);
	static public inline function lineWidth(width:Float):Void
		GL.lineWidth(width);
	static public inline function sampleCoverage(value:Float, invert:Bool):Void
		GL.sampleCoverage(value, invert);
	static public inline function polygonOffset(factor:Float, units:Float):Void
		GL.polygonOffset(factor, units);
	static public inline function colorMask(red:Bool, green:Bool, blue:Bool, alpha:Bool):Void
		GL.colorMask(red, green, blue, alpha);
	static public inline function pixelStorei(pname:PixelStorageMode, param:Int):Void
		GL.pixelStorei(pname, param);
	//Clear
	static public inline function clearColor(red:Float, green:Float, blue:Float, alpha:Float):Void
		GL.clearColor(red, green, blue, alpha);
	static public inline function clearDepth(depth:Float):Void
		GL.clearDepth(depth);
	static public inline function clearStencil(s:Int):Void
		GL.clearStencil(s);
	//Depth
	static public inline function depthFunc(func:Comparison):Void
		GL.depthFunc(func);
	static public inline function depthMask(flag:Bool):Void
		GL.depthMask(flag);
	static public inline function depthRange(zNear:Float, zFar:Float):Void
		GL.depthRange(zNear, zFar);
	//Stencil
	static public inline function stencilFunc(func:Comparison, ref:Int, mask:Int):Void
		GL.stencilFunc(func, ref, mask);
	static public inline function stencilFuncSeparate(face:FaceMode, func:Comparison, ref:Int, mask:Int):Void
		GL.stencilFuncSeparate(face, func, ref, mask);
	static public inline function stencilMask(mask:Int):Void
		GL.stencilMask(mask);
	static public inline function stencilMaskSeparate(face:FaceMode, mask:Int):Void
		GL.stencilMaskSeparate(face, mask);
	static public inline function stencilOp(fail:Action, zfail:Action, zpass:Action):Void
		GL.stencilOp(fail, zfail, zpass);
	static public inline function stencilOpSeparate(face:FaceMode, fail:Action, zfail:Action, zpass:Action):Void
		GL.stencilOpSeparate(face, fail, zfail, zpass);
	//Blending
	static public inline function blendColor(red:Float, green:Float, blue:Float, alpha:Float):Void
		GL.blendColor(red, green, blue, alpha);
	static public inline function blendEquation(mode:BlendEquation):Void
		GL.blendEquation(mode);
	static public inline function blendEquationSeparate(modeRGB:BlendEquation, modeAlpha:BlendEquation):Void
		GL.blendEquationSeparate(modeRGB, modeAlpha);
	static public inline function blendFunc(sfactor:BlendFactor, dfactor:BlendFactor):Void
		GL.blendFunc(sfactor, dfactor);
	static public inline function blendFuncSeparate(srcRGB:BlendFactor, dstRGB:BlendFactor, srcAlpha:BlendFactor, dstAlpha:BlendFactor):Void
		GL.blendFuncSeparate(srcRGB, dstRGB, srcAlpha, dstAlpha);
	//Extensions
	static public inline function getExtension(name:String):Dynamic
		return GL.getExtension(name);
	static public inline function getSupportedExtensions():Array<String>
		return GL.getSupportedExtensions();


	/* Query Global State */
	static public inline function getParameter(pname:Parameter):Dynamic
		return GL.getParameter(pname);
	static public inline function getError():ErrorCode
		return GL.getError();
	static public inline function getContextAttributes():GLContextAttributes
		return GL.getContextAttributes();


	/* Execution control */
	static public inline function finish():Void
		GL.finish();
	static public inline function flush():Void
		GL.flush();


	/* Draw */
	static public inline function clear(mask:ClearBit):Void
		GL.clear(mask);

	//@! potentially replace with calls to FormattedData
	// static public inline function drawArrays(mode:DrawMode, first:Int, count:Int):Void
	// 	GL.drawArrays(mode, first, count);
	// static public inline function drawElements(mode:DrawMode, count:Int, type:IndicesType, offset:Int):Void
	// 	GL.drawElements(mode, count, type, offset);

	static public inline function viewport(x:Int, y:Int, width:Int, height:Int):Void
		GL.viewport(x, y, width, height);
	static public inline function scissor(x:Int, y:Int, width:Int, height:Int):Void
		GL.scissor(x, y, width, height);


	/* Properties */
	//(caches properties)
	static private function get_MAX_VERTEX_ATTRIBS():Null<Int>{
		if(MAX_VERTEX_ATTRIBS == null)
			MAX_VERTEX_ATTRIBS = GL.getParameter(GL.MAX_VERTEX_ATTRIBS);
		return MAX_VERTEX_ATTRIBS;
	}

	static private function get_MAX_VARYING_VECTORS():Null<Int>{
		if(MAX_VARYING_VECTORS == null)
			MAX_VARYING_VECTORS = GL.getParameter(GL.MAX_VARYING_VECTORS);
		return MAX_VARYING_VECTORS;
	}

	static private function get_MAX_VERTEX_UNIFORM_VECTORS():Null<Int>{
		if(MAX_VERTEX_UNIFORM_VECTORS == null)
			MAX_VERTEX_UNIFORM_VECTORS = GL.getParameter(GL.MAX_VERTEX_UNIFORM_VECTORS);
		return MAX_VERTEX_UNIFORM_VECTORS;
	}

	static private function get_MAX_FRAGMENT_UNIFORM_VECTORS():Null<Int>{
		if(MAX_FRAGMENT_UNIFORM_VECTORS == null)
			MAX_FRAGMENT_UNIFORM_VECTORS = GL.getParameter(GL.MAX_FRAGMENT_UNIFORM_VECTORS);
		return MAX_FRAGMENT_UNIFORM_VECTORS;
	}

	static private function get_MAX_TEXTURE_IMAGE_UNITS():Null<Int>{
		if(MAX_TEXTURE_IMAGE_UNITS == null)
			MAX_TEXTURE_IMAGE_UNITS = GL.getParameter(GL.MAX_TEXTURE_IMAGE_UNITS);
		return MAX_TEXTURE_IMAGE_UNITS;
	}

	static private function get_MAX_VERTEX_TEXTURE_IMAGE_UNITS():Null<Int>{
		if(MAX_VERTEX_TEXTURE_IMAGE_UNITS == null)
			MAX_VERTEX_TEXTURE_IMAGE_UNITS = GL.getParameter(GL.MAX_VERTEX_TEXTURE_IMAGE_UNITS);
		return MAX_VERTEX_TEXTURE_IMAGE_UNITS;
	}

	static private function get_MAX_COMBINED_TEXTURE_IMAGE_UNITS():Null<Int>{
		if(MAX_COMBINED_TEXTURE_IMAGE_UNITS == null)
			MAX_COMBINED_TEXTURE_IMAGE_UNITS = GL.getParameter(GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS);
		return MAX_COMBINED_TEXTURE_IMAGE_UNITS;
	}

	static private function get_MAX_TEXTURE_SIZE():Null<Int>{
		if(MAX_TEXTURE_SIZE == null)
			MAX_TEXTURE_SIZE = GL.getParameter(GL.MAX_TEXTURE_SIZE);
		return MAX_TEXTURE_SIZE;
	}

	static private function get_MAX_CUBE_MAP_TEXTURE_SIZE():Null<Int>{
		if(MAX_CUBE_MAP_TEXTURE_SIZE == null)
			MAX_CUBE_MAP_TEXTURE_SIZE = GL.getParameter(GL.MAX_CUBE_MAP_TEXTURE_SIZE);
		return MAX_CUBE_MAP_TEXTURE_SIZE;
	}

	static private function get_MAX_RENDERBUFFER_SIZE():Null<Int>{
		if(MAX_RENDERBUFFER_SIZE == null)
			MAX_RENDERBUFFER_SIZE = GL.getParameter(GL.MAX_RENDERBUFFER_SIZE);
		return MAX_RENDERBUFFER_SIZE;
	}

}

/* Constants */

//General
@:enum
abstract Comparison(Int) to Int from Int{
	var NEVER                              = GL.NEVER;
	var LESS                               = GL.LESS;
	var EQUAL                              = GL.EQUAL;
	var LEQUAL                             = GL.LEQUAL;
	var GREATER                            = GL.GREATER;
	var NOTEQUAL                           = GL.NOTEQUAL;
	var GEQUAL                             = GL.GEQUAL;
	var ALWAYS                             = GL.ALWAYS;
}

@:enum
abstract FaceMode(Int) to Int from Int{
	var FRONT                              = GL.FRONT;
	var BACK                               = GL.BACK;
	var FRONT_AND_BACK                     = GL.FRONT_AND_BACK;
}

@:enum
abstract Action(Int) to Int from Int{
	var ZERO                               = GL.ZERO;
	var KEEP                               = GL.KEEP;
	var REPLACE                            = GL.REPLACE;
	var INCR                               = GL.INCR;
	var DECR                               = GL.DECR;
	var INVERT                             = GL.INVERT;
	var INCR_WRAP                          = GL.INCR_WRAP;
	var DECR_WRAP                          = GL.DECR_WRAP;
}

@:enum
abstract Parameter(Int) to Int from Int{
	var ACTIVE_TEXTURE                     = GL.ACTIVE_TEXTURE;
	var ALIASED_LINE_WIDTH_RANGE           = GL.ALIASED_LINE_WIDTH_RANGE;
	var ALIASED_POINT_SIZE_RANGE           = GL.ALIASED_POINT_SIZE_RANGE;
	var ALPHA_BITS                         = GL.ALPHA_BITS;
	var ARRAY_BUFFER_BINDING               = GL.ARRAY_BUFFER_BINDING;
	var BLEND                              = GL.BLEND;
	var BLEND_COLOR                        = GL.BLEND_COLOR;
	var BLEND_DST_ALPHA                    = GL.BLEND_DST_ALPHA;
	var BLEND_DST_RGB                      = GL.BLEND_DST_RGB;
	var BLEND_EQUATION_ALPHA               = GL.BLEND_EQUATION_ALPHA;
	var BLEND_EQUATION_RGB                 = GL.BLEND_EQUATION_RGB;
	var BLEND_SRC_ALPHA                    = GL.BLEND_SRC_ALPHA;
	var BLEND_SRC_RGB                      = GL.BLEND_SRC_RGB;
	var BLUE_BITS                          = GL.BLUE_BITS;
	var COLOR_CLEAR_VALUE                  = GL.COLOR_CLEAR_VALUE;
	var COLOR_WRITEMASK                    = GL.COLOR_WRITEMASK;
	var COMPRESSED_TEXTURE_FORMATS         = GL.COMPRESSED_TEXTURE_FORMATS;
	var CULL_FACE                          = GL.CULL_FACE;
	var CULL_FACE_MODE                     = GL.CULL_FACE_MODE;
	var CURRENT_PROGRAM                    = GL.CURRENT_PROGRAM;
	var DEPTH_BITS                         = GL.DEPTH_BITS;
	var DEPTH_CLEAR_VALUE                  = GL.DEPTH_CLEAR_VALUE;
	var DEPTH_FUNC                         = GL.DEPTH_FUNC;
	var DEPTH_RANGE                        = GL.DEPTH_RANGE;
	var DEPTH_TEST                         = GL.DEPTH_TEST;
	var DEPTH_WRITEMASK                    = GL.DEPTH_WRITEMASK;
	var DITHER                             = GL.DITHER;
	var ELEMENT_ARRAY_BUFFER_BINDING       = GL.ELEMENT_ARRAY_BUFFER_BINDING;
	var FRAMEBUFFER_BINDING                = GL.FRAMEBUFFER_BINDING;
	var FRONT_FACE                         = GL.FRONT_FACE;
	var GENERATE_MIPMAP_HINT               = GL.GENERATE_MIPMAP_HINT;
	var GREEN_BITS                         = GL.GREEN_BITS;
	var IMPLEMENTATION_COLOR_READ_FORMAT   = GL.IMPLEMENTATION_COLOR_READ_FORMAT;
	var IMPLEMENTATION_COLOR_READ_TYPE     = GL.IMPLEMENTATION_COLOR_READ_TYPE;
	var LINE_WIDTH                         = GL.LINE_WIDTH;
	var MAX_COMBINED_TEXTURE_IMAGE_UNITS   = GL.MAX_COMBINED_TEXTURE_IMAGE_UNITS;
	var MAX_CUBE_MAP_TEXTURE_SIZE          = GL.MAX_CUBE_MAP_TEXTURE_SIZE;
	var MAX_FRAGMENT_UNIFORM_VECTORS       = GL.MAX_FRAGMENT_UNIFORM_VECTORS;
	var MAX_RENDERBUFFER_SIZE              = GL.MAX_RENDERBUFFER_SIZE;
	var MAX_TEXTURE_IMAGE_UNITS            = GL.MAX_TEXTURE_IMAGE_UNITS;
	var MAX_TEXTURE_SIZE                   = GL.MAX_TEXTURE_SIZE;
	var MAX_VARYING_VECTORS                = GL.MAX_VARYING_VECTORS;
	var MAX_VERTEX_ATTRIBS                 = GL.MAX_VERTEX_ATTRIBS;
	var MAX_VERTEX_TEXTURE_IMAGE_UNITS     = GL.MAX_VERTEX_TEXTURE_IMAGE_UNITS;
	var MAX_VERTEX_UNIFORM_VECTORS         = GL.MAX_VERTEX_UNIFORM_VECTORS;
	var MAX_VIEWPORT_DIMS                  = GL.MAX_VIEWPORT_DIMS;
	var PACK_ALIGNMENT                     = GL.PACK_ALIGNMENT;
	var POLYGON_OFFSET_FACTOR              = GL.POLYGON_OFFSET_FACTOR;
	var POLYGON_OFFSET_FILL                = GL.POLYGON_OFFSET_FILL;
	var POLYGON_OFFSET_UNITS               = GL.POLYGON_OFFSET_UNITS;
	var RED_BITS                           = GL.RED_BITS;
	var RENDERBUFFER_BINDING               = GL.RENDERBUFFER_BINDING;
	var RENDERER                           = GL.RENDERER;
	var SAMPLE_BUFFERS                     = GL.SAMPLE_BUFFERS;
	var SAMPLE_COVERAGE_INVERT             = GL.SAMPLE_COVERAGE_INVERT;
	var SAMPLE_COVERAGE_VALUE              = GL.SAMPLE_COVERAGE_VALUE;
	var SAMPLES                            = GL.SAMPLES;
	var SCISSOR_BOX                        = GL.SCISSOR_BOX;
	var SCISSOR_TEST                       = GL.SCISSOR_TEST;
	var SHADING_LANGUAGE_VERSION           = GL.SHADING_LANGUAGE_VERSION;
	var STENCIL_BACK_FAIL                  = GL.STENCIL_BACK_FAIL;
	var STENCIL_BACK_FUNC                  = GL.STENCIL_BACK_FUNC;
	var STENCIL_BACK_PASS_DEPTH_FAIL       = GL.STENCIL_BACK_PASS_DEPTH_FAIL;
	var STENCIL_BACK_PASS_DEPTH_PASS       = GL.STENCIL_BACK_PASS_DEPTH_PASS;
	var STENCIL_BACK_REF                   = GL.STENCIL_BACK_REF;
	var STENCIL_BACK_VALUE_MASK            = GL.STENCIL_BACK_VALUE_MASK;
	var STENCIL_BACK_WRITEMASK             = GL.STENCIL_BACK_WRITEMASK;
	var STENCIL_BITS                       = GL.STENCIL_BITS;
	var STENCIL_CLEAR_VALUE                = GL.STENCIL_CLEAR_VALUE;
	var STENCIL_FAIL                       = GL.STENCIL_FAIL;
	var STENCIL_FUNC                       = GL.STENCIL_FUNC;
	var STENCIL_PASS_DEPTH_FAIL            = GL.STENCIL_PASS_DEPTH_FAIL;
	var STENCIL_PASS_DEPTH_PASS            = GL.STENCIL_PASS_DEPTH_PASS;
	var STENCIL_REF                        = GL.STENCIL_REF;
	var STENCIL_TEST                       = GL.STENCIL_TEST;
	var STENCIL_VALUE_MASK                 = GL.STENCIL_VALUE_MASK;
	var STENCIL_WRITEMASK                  = GL.STENCIL_WRITEMASK;
	var SUBPIXEL_BITS                      = GL.SUBPIXEL_BITS;
	var TEXTURE_BINDING_2D                 = GL.TEXTURE_BINDING_2D;
	var TEXTURE_BINDING_CUBE_MAP           = GL.TEXTURE_BINDING_CUBE_MAP;
	var UNPACK_ALIGNMENT                   = GL.UNPACK_ALIGNMENT;
	var VENDOR                             = GL.VENDOR;
	var VERSION                            = GL.VERSION;
	var VIEWPORT                           = GL.VIEWPORT;
	//webgl specific
	var UNPACK_FLIP_Y_WEBGL                = WebGLSpecific.UNPACK_FLIP_Y_WEBGL;
	var UNPACK_PREMULTIPLY_ALPHA_WEBGL     = WebGLSpecific.UNPACK_PREMULTIPLY_ALPHA_WEBGL;
	var UNPACK_COLORSPACE_CONVERSION_WEBGL = WebGLSpecific.UNPACK_COLORSPACE_CONVERSION_WEBGL;
}

@:enum
abstract DataType(Int) to Int from Int{
	var BYTE                               = GL.BYTE;
	var UNSIGNED_BYTE                      = GL.UNSIGNED_BYTE;
	var SHORT                              = GL.SHORT;
	var UNSIGNED_SHORT                     = GL.UNSIGNED_SHORT;
	var INT                                = GL.INT;
	var UNSIGNED_INT                       = GL.UNSIGNED_INT;
	var FLOAT                              = GL.FLOAT;
}

//Error Codes
@:enum
abstract ErrorCode(Int) to Int from Int{
	var NO_ERROR                           = GL.NO_ERROR;
	var INVALID_ENUM                       = GL.INVALID_ENUM;
	var INVALID_VALUE                      = GL.INVALID_VALUE;
	var INVALID_OPERATION                  = GL.INVALID_OPERATION;
	var GL_INVALID_FRAMEBUFFER_OPERATION   = GL.INVALID_FRAMEBUFFER_OPERATION;
	var OUT_OF_MEMORY                      = GL.OUT_OF_MEMORY;
}

//Capabilities
@:enum
abstract Capability(Int) to Int from Int{
	var BLEND                              = GL.BLEND;
	var CULL_FACE                          = GL.CULL_FACE;
	var DEPTH_TEST                         = GL.DEPTH_TEST;
	var DITHER                             = GL.DITHER;
	var POLYGON_OFFSET_FILL                = GL.POLYGON_OFFSET_FILL;
	var SAMPLE_ALPHA_TO_COVERAGE           = GL.SAMPLE_ALPHA_TO_COVERAGE;
	var SAMPLE_COVERAGE                    = GL.SAMPLE_COVERAGE;
	var SCISSOR_TEST                       = GL.SCISSOR_TEST;
	var STENCIL_TEST                       = GL.STENCIL_TEST;
}

//Face Culling
@:enum
abstract FrontFaceMode(Int) to Int from Int{
	var CW                                 = GL.CW;
	var CCW                                = GL.CCW;
}

//Hint
@:enum
abstract HintMode(Int) to Int from Int{
	var DONT_CARE                          = GL.DONT_CARE;
	var FASTEST                            = GL.FASTEST;
	var NICEST                             = GL.NICEST;
}

@:enum
abstract HintTarget(Int) to Int from Int{
	var GENERATE_MIPMAP_HINT               = GL.GENERATE_MIPMAP_HINT;
}

//Blending
@:enum
abstract BlendEquation(Int) to Int from Int{
	var FUNC_ADD                           = GL.FUNC_ADD;
	var FUNC_SUBTRACT                      = GL.FUNC_SUBTRACT;
	var FUNC_REVERSE_SUBTRACT              = GL.FUNC_REVERSE_SUBTRACT;
}

@:enum
abstract BlendFactor(Int) to Int from Int{
	var ZERO                               = GL.ZERO;
	var ONE                                = GL.ONE;
	var SRC_COLOR                          = GL.SRC_COLOR;
	var ONE_MINUS_SRC_COLOR                = GL.ONE_MINUS_SRC_COLOR;
	var DST_COLOR                          = GL.DST_COLOR;
	var ONE_MINUS_DST_COLOR                = GL.ONE_MINUS_DST_COLOR;
	var SRC_ALPHA                          = GL.SRC_ALPHA;
	var ONE_MINUS_SRC_ALPHA                = GL.ONE_MINUS_SRC_ALPHA;
	var DST_ALPHA                          = GL.DST_ALPHA;
	var ONE_MINUS_DST_ALPHA                = GL.ONE_MINUS_DST_ALPHA;
	var CONSTANT_COLOR                     = GL.CONSTANT_COLOR;
	var ONE_MINUS_CONSTANT_COLOR           = GL.ONE_MINUS_CONSTANT_COLOR;
	var CONSTANT_ALPHA                     = GL.CONSTANT_ALPHA;
	var ONE_MINUS_CONSTANT_ALPHA           = GL.ONE_MINUS_CONSTANT_ALPHA;
	var SRC_ALPHA_SATURATE                 = GL.SRC_ALPHA_SATURATE;
}

//Draw
@:enum
abstract ClearBit(Int) to Int from Int{
	var DEPTH_BUFFER_BIT                   = GL.DEPTH_BUFFER_BIT;
	var STENCIL_BUFFER_BIT                 = GL.STENCIL_BUFFER_BIT;
	var COLOR_BUFFER_BIT                   = GL.COLOR_BUFFER_BIT;
}

@:enum
abstract DrawMode(Int) to Int from Int{
	var POINTS                             = GL.POINTS;
	var LINES                              = GL.LINES;
	var LINE_LOOP                          = GL.LINE_LOOP;
	var LINE_STRIP                         = GL.LINE_STRIP;
	var TRIANGLES                          = GL.TRIANGLES;
	var TRIANGLE_STRIP                     = GL.TRIANGLE_STRIP;
	var TRIANGLE_FAN                       = GL.TRIANGLE_FAN;
}

@:enum 
abstract IndicesType(Int) to Int from Int{//subset of DataType
	var UNSIGNED_BYTE                      = GL.UNSIGNED_BYTE;
	var UNSIGNED_SHORT                     = GL.UNSIGNED_SHORT;
}

//Texture
@:enum
abstract TextureTarget(Int) to Int from Int{
	var TEXTURE_2D                         = GL.TEXTURE_2D;
	var TEXTURE_CUBE_MAP                   = GL.TEXTURE_CUBE_MAP;
	var TEXTURE_CUBE_MAP_POSITIVE_X        = GL.TEXTURE_CUBE_MAP_POSITIVE_X;
	var TEXTURE_CUBE_MAP_NEGATIVE_X        = GL.TEXTURE_CUBE_MAP_NEGATIVE_X;
	var TEXTURE_CUBE_MAP_POSITIVE_Y        = GL.TEXTURE_CUBE_MAP_POSITIVE_Y;
	var TEXTURE_CUBE_MAP_NEGATIVE_Y        = GL.TEXTURE_CUBE_MAP_NEGATIVE_Y;
	var TEXTURE_CUBE_MAP_POSITIVE_Z        = GL.TEXTURE_CUBE_MAP_POSITIVE_Z;
	var TEXTURE_CUBE_MAP_NEGATIVE_Z        = GL.TEXTURE_CUBE_MAP_NEGATIVE_Z;
}

@:enum
abstract PixelType(Int) to Int from Int{
	var UNSIGNED_BYTE                      = GL.UNSIGNED_BYTE;
	var UNSIGNED_SHORT_4_4_4_4             = GL.UNSIGNED_SHORT_4_4_4_4;
	var UNSIGNED_SHORT_5_5_5_1             = GL.UNSIGNED_SHORT_5_5_5_1;
	var UNSIGNED_SHORT_5_6_5               = GL.UNSIGNED_SHORT_5_6_5;
}

@:enum
abstract MinFilter(Int) to Int from Int{
	var NEAREST_MIPMAP_NEAREST             = GL.NEAREST_MIPMAP_NEAREST;
	var LINEAR_MIPMAP_NEAREST              = GL.LINEAR_MIPMAP_NEAREST;
	var NEAREST_MIPMAP_LINEAR              = GL.NEAREST_MIPMAP_LINEAR;
	var LINEAR_MIPMAP_LINEAR               = GL.LINEAR_MIPMAP_LINEAR;
}

@:enum
abstract MagFilter(Int) to Int from Int{
	var NEAREST                            = GL.NEAREST;
	var LINEAR                             = GL.LINEAR;
}

@:enum
abstract Format(Int) to Int from Int{
	var DEPTH_COMPONENT                    = GL.DEPTH_COMPONENT;
	var ALPHA                              = GL.ALPHA;
	var RGB                                = GL.RGB;
	var RGBA                               = GL.RGBA;
	var LUMINANCE                          = GL.LUMINANCE;
	var LUMINANCE_ALPHA                    = GL.LUMINANCE_ALPHA;
}

@:enum
abstract WrapMode(Int) to Int from Int{
	var REPEAT                             = GL.REPEAT;
	var CLAMP_TO_EDGE                      = GL.CLAMP_TO_EDGE;
	var MIRRORED_REPEAT                    = GL.MIRRORED_REPEAT;
}

@:enum
abstract PixelStorageMode(Int) to Int from Int{
	var UNPACK_ALIGNMENT                   = GL.UNPACK_ALIGNMENT;
	var PACK_ALIGNMENT                     = GL.PACK_ALIGNMENT;
	//webgl specific
	var UNPACK_FLIP_Y_WEBGL                = WebGLSpecific.UNPACK_FLIP_Y_WEBGL;
	var UNPACK_PREMULTIPLY_ALPHA_WEBGL     = WebGLSpecific.UNPACK_PREMULTIPLY_ALPHA_WEBGL;
	var UNPACK_COLORSPACE_CONVERSION_WEBGL = WebGLSpecific.UNPACK_COLORSPACE_CONVERSION_WEBGL;
}

//WebGL Specific
@:enum
abstract WebGLSpecific(Int) to Int from Int{
	var UNPACK_FLIP_Y_WEBGL                = 0x9240;
	var UNPACK_PREMULTIPLY_ALPHA_WEBGL     = 0x9241;
	var UNPACK_COLORSPACE_CONVERSION_WEBGL = 0x9243;
	var CONTEXT_LOST_WEBGL                 = 0x9242;
	var BROWSER_DEFAULT_WEBGL              = 0x9244;
}