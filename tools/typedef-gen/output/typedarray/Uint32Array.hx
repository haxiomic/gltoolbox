package gltoolbox.typedarray;

#if snow
typedef Uint32Array = snow.api.buffers.Uint32Array;
#elseif lime
typedef Uint32Array = lime.utils.Uint32Array;
#elseif nme
typedef Uint32Array = nme.utils.Uint32Array;
#elseif hxsdl
// ...
#elseif js
typedef Uint32Array = js.html.Uint32Array;
#end
