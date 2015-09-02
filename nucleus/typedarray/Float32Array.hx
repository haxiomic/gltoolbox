package nucleus.typedarray;

#if snow
typedef Float32Array = snow.api.buffers.Float32Array;
#elseif lime
typedef Float32Array = lime.utils.Float32Array;
#elseif nme
typedef Float32Array = nme.utils.Float32Array;
#elseif hxsdl
// ...
#elseif js
typedef Float32Array = js.html.Float32Array;
#else
typedef Float32Array = haxe.io.Float32Array;
#end
