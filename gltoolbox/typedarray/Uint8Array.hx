package gltoolbox.typedarray;

#if snow
typedef Uint8Array = snow.api.buffers.Uint8Array;
#elseif lime
typedef Uint8Array = lime.utils.Uint8Array;
#elseif nme
typedef Uint8Array = nme.utils.Uint8Array;
#elseif hxsdl
// ...
#elseif js
typedef Uint8Array = js.html.Uint8Array;
#else
typedef Uint8Array = haxe.io.Uint8Array;
#end
