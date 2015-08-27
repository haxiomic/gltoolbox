/*
	Texture

	@! todo
	- Dynamic data with needsUpdate:Bool
	- Automatic mip-mapping support
	- Parameter changing?
	- anisotropy support
*/

package gltoolbox.texture;

import gltoolbox.typedarray.ArrayBufferView;
import gltoolbox.gl.GL;
import gltoolbox.Constants;

class Texture{

	public var width:Int;
	public var height:Int;
	public var data:ArrayBufferView;

	public var format:Formats;
	public var dataType:DataTypes;
	public var minFilter:MinFilters;
	public var magFilter:MagFilters;
	public var wrapS:WrapModes;
	public var wrapT:WrapModes;
	public var unpackAlignment:Int;
	public var anisotropy:Int;

	public var target:Targets = Targets.TEXTURE_2D;
	public var glTexture:GLTexture;

	private var unit:Null<Int>;

	public function new(
		data:ArrayBufferView,
		width:Int,
		height:Int,
		format:Formats = Formats.RGBA,
		dataType:DataTypes = DataTypes.UNSIGNED_BYTE,
		minFilter:MinFilters = MinFilters.LINEAR_MIPMAP_LINEAR,
		magFilter:MagFilters = MagFilters.LINEAR,
		wrapS:WrapModes = WrapModes.CLAMP_TO_EDGE,
		wrapT:WrapModes = WrapModes.CLAMP_TO_EDGE,
		unpackAlignment:Int = 4,
		anisotropy:Int = 1
	){
		this.width = width;
		this.height = height;
		this.data = data;
		this.format = format;
		this.dataType = dataType;
		this.minFilter = minFilter;
		this.magFilter = magFilter;
		this.wrapS = wrapS;
		this.wrapT = wrapT;
		this.unpackAlignment = unpackAlignment;
		this.anisotropy = anisotropy;
	}

	public function allocate():Texture{
		glTexture = GL.createTexture();

		Texture.assignUnit(this);

		//set params
		GL.texParameteri(target, GL.TEXTURE_MIN_FILTER, minFilter); 
		GL.texParameteri(target, GL.TEXTURE_MAG_FILTER, magFilter); 
		GL.texParameteri(target, GL.TEXTURE_WRAP_S, wrapS);
		GL.texParameteri(target, GL.TEXTURE_WRAP_T, wrapT);

		GL.pixelStorei(GL.UNPACK_ALIGNMENT, unpackAlignment); //see http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml

		//set data
		var lod:Int = 0;
		var border:Int = 0;//width of the border. Must be 0. Border value used only when UInt8Array or Float32Array for pixels is specified.
		GL.texImage2D(target, lod, format, width, height, border, format, dataType, data);

		return this;
	}

	public function dispose():Texture{
		if(unit != null)
			Texture.clearUnit(unit);

		GL.deleteTexture(glTexture);
		glTexture = null;

		return this;
	}
	
	//static

	static private var units:Vector<Texture> = new Vector<Texture>(32); //WebGL limits us to 32
	static private var unitIdx:Int = 0;
	static private var maxUnits(get, null):Null<Int> = null;

	//idea is that a texture unit will last be good for at least 1 shader
	static public function assignUnit(texture:Texture):Int{
		//CPU-side
		//texture already bound to a slot, no need to re-bind
		if(texture.unit != null)
			return texture.unit;

		var u = unitIdx;
		advanceUnit();

		//clear texture already in unit
		if(units[u] != null)
			units[u].unit = null;

		//put texture in current unit
		units[u] = texture;
		texture.unit = u;

		//GPU-side
		GL.activeTexture(GL.TEXTURE0 + unit);
		GL.bindTexture(texture.target, texture.glTexture);

		return u;
	}

	static public inline function resetUnitIndex(){
		unitIdx = 0;
	}

	static public inline function clearUnit(u:Int){
		//GPU-side
		GL.activeTexture(GL.TEXTURE0 + u);
		GL.bindTexture(units[u].target, null);

		//CPU-side
		units[u].unit = null;
		units[u] = null;
	}

	//private

	static private inline function advanceUnit():Void{
		//wrap around unit limit
		unitIdx = (unitIdx+1)%maxUnits;
	}

	//properties

	static private inline function get_maxUnits():Null<Int>{
		if(maxUnits == null){
			var deviceMax = GPU.MAX_COMBINED_TEXTURE_IMAGE_UNITS;
			//cap max units by length of vector on CPU
			maxUnits = deviceMax < units.length ? deviceMax : units.length;
		}

		return maxUnits;
	}

}