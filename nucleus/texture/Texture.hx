/*
	Texture

	@! todo
	- Texture options object
	- Flip Y for webgl
	- Parameter changing?
	- Dynamic data with needsUpdate:Bool
	- Automatic mip-mapping support
	- anisotropy support

	All texture functions:
	- compressedTexImage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, data:ArrayBufferView):Void
	- compressedTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, data:ArrayBufferView):Void
	- copyTexImage2D(target:Int, level:Int, internalformat:Int, x:Int, y:Int, width:Int, height:Int, border:Int):Void
	- copyTexSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, x:Int, y:Int, width:Int, height:Int):Void
	- texImage2D(target:Int, level:Int, internalformat:Int, width:Int, height:Int, border:Int, format:Int, type:Int, data:ArrayBufferView):Void
	- texParameterf(target:Int, pname:Int, param:Float):Void
	- texParameteri(target:Int, pname:Int, param:Int):Void
	- texSubImage2D(target:Int, level:Int, xoffset:Int, yoffset:Int, width:Int, height:Int, format:Int, type:Int, data:ArrayBufferView):Void
	- generateMipmap(target:Int):Void
	- getTexParameter(target:Int, pname:Int):Dynamic
*/

package nucleus.texture;

import nucleus.typedarray.ArrayBufferView;
import nucleus.gl.GL;
import nucleus.Constants;

class Texture{

	public var data(get, set):ArrayBufferView;
	public var width(get, set):Int;
	public var height(get, set):Int;

	public var format(get, set):Format;
	public var dataType(get, set):DataType;
	public var minFilter(get, set):MinFilter;
	public var magFilter(get, set):MagFilter;
	public var wrapS(get, set):WrapMode;
	public var wrapT(get, set):WrapMode;
	public var unpackAlignment(get, set):Int;
	public var anisotropy(get, set):Int;

	public var target(get, null):Targets = Targets.TEXTURE_2D;

	private var glTexture(get, null):GLTexture;
	private var unit:Null<Int>;

	public function new(
		data:ArrayBufferView,
		width:Int,
		height:Int,
		format:Format = Format.RGBA,
		dataType:DataType = DataType.UNSIGNED_BYTE,
		minFilter:MinFilter = MinFilter.LINEAR_MIPMAP_LINEAR,
		magFilter:MagFilter = MagFilter.LINEAR,
		wrapS:WrapMode = WrapMode.CLAMP_TO_EDGE,
		wrapT:WrapMode = WrapMode.CLAMP_TO_EDGE,
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

	public function initialize():Texture{
		glTexture = GL.createTexture();

		Texture.activate(this);

		//set params
		GL.texParameteri(target, GL.TEXTURE_MIN_FILTER, minFilter); 
		GL.texParameteri(target, GL.TEXTURE_MAG_FILTER, magFilter); 
		GL.texParameteri(target, GL.TEXTURE_WRAP_S, wrapS);
		GL.texParameteri(target, GL.TEXTURE_WRAP_T, wrapT);

		GL.pixelStorei(GL.UNPACK_ALIGNMENT, unpackAlignment); //see http://www.khronos.org/opengles/sdk/docs/man/xhtml/glPixelStorei.xml

		//set data
		var lod:Int = 0;//mip-map level of detail
		var border:Int = 0;//width of the border, must be 0 (not supported in ES)
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
	static private var units:Vector<Texture> = new Vector<Texture>(32); //2.0 sets the minimum at 32, this is resized if device supports more
	static private var unitIdx:Int = 0;
	static private var maxUnits(get, null):Null<Int> = null;

	static private function assignUnit(texture:Texture):Int{
		//in principle, a texture unit will be good for at least 1 shader
		//CPU-side
		var u:Int;
		if(texture.unit != null){
			//texture already bound to a unit, no need to re-bind
			u = texture.unit;
		}else{
			u = unitIdx;
			advanceUnit();

			//clear texture already in unit
			if(units[u] != null)
				units[u].unit = null;

			//put texture in current unit
			units[u] = texture;
			texture.unit = u;

			//GPU-side
			GL.activeTexture(GL.TEXTURE0 + texture.unit);
			GL.bindTexture(texture.target, texture.glTexture);
		}

		return u;
	}

	static private inline function activate(texture:Texture){
		if(texture.unit == null)
			assignUnit(texture);
		//GPU-side
		GL.activeTexture(GL.TEXTURE0 + texture.unit);
		GL.bindTexture(texture.target, texture.glTexture);
	}

	//ensures that texture unit bindings on the GPU match the CPU
	//only to be used if some code alters texture unit bindings
	static private inline function synchroniseUnits(){
		for(u in 0...maxUnits){
			if(units[u] != null && units[u].unit != null){
				//GPU-side
				GL.activeTexture(GL.TEXTURE0 + texture.unit);
				GL.bindTexture(texture.target, texture.glTexture);
			}
		}
	}

	static private inline function resetUnitIndex(){
		unitIdx = 0;
	}

	static private inline function clearUnit(u:Int){
		//GPU-side
		GL.activeTexture(GL.TEXTURE0 + u);
		GL.bindTexture(units[u].target, null);

		//CPU-side
		units[u].unit = null;
		units[u] = null;
	}

	static private inline function advanceUnit():Void{
		//wrap around unit limit
		unitIdx = (unitIdx+1)%maxUnits;
	}

	/* Properties */
	static private inline function get_maxUnits():Null<Int>{
		if(maxUnits == null){
			var deviceMax = GPU.MAX_COMBINED_TEXTURE_IMAGE_UNITS;
			//now we've discovered max, resize vector of textures if device supports more
			if(deviceMax > units.length){
				var newUnits = new Vector<Texture>(deviceMax);
				//copy over any textures already set
				for(u in units)
					newUnits[u] = units[u];
				//replace
				units = newUnits;
			}

			maxUnits = deviceMax;
		}

		return maxUnits;
	}

}