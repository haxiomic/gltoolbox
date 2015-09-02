package nucleus.texture;

import nucleus.Constants;

class TextureCubeMap extends Texture{

	//@! three.js uses images array

	var dataPositiveX:ArrayBufferView;
	var dataNegativeX:ArrayBufferView;
	var dataPositiveY:ArrayBufferView;
	var dataNegativeY:ArrayBufferView;
	var dataPositiveZ:ArrayBufferView;
	var dataNegativeZ:ArrayBufferView;


	public function new(){
		throw 'todo';//@!
		super();
		this.target = Targets.TEXTURE_CUBE_MAP;
	}

}