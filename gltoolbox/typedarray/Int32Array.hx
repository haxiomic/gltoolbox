package gltoolbox.typedarray;

#if snow
typedef Int32Array = snow.api.buffers.Int32Array;
#elseif lime
typedef Int32Array = lime.utils.Int32Array;
#elseif nme
typedef Int32Array = nme.utils.Int32Array;
#elseif hxsdl
// ...
#elseif js
typedef Int32Array = js.html.Int32Array;
#else
typedef Int32Array = haxe.io.Int32Array;
#end
