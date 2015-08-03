package gltoolbox.typedarray;

#if snow
typedef Int8Array = snow.api.buffers.Int8Array;
#elseif lime
typedef Int8Array = lime.utils.Int8Array;
#elseif nme
typedef Int8Array = nme.utils.Int8Array;
#elseif hxsdl
// ...
#elseif js
typedef Int8Array = js.html.Int8Array;
#end
