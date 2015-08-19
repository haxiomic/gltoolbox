package gltoolbox.typedarray;

#if snow
typedef Int16Array = snow.api.buffers.Int16Array;
#elseif lime
typedef Int16Array = lime.utils.Int16Array;
#elseif nme
typedef Int16Array = nme.utils.Int16Array;
#elseif hxsdl
// ...
#elseif js
typedef Int16Array = js.html.Int16Array;
#else
typedef Int16Array = haxe.io.Int16Array;
#end
