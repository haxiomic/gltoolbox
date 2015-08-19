package gltoolbox.typedarray;

#if snow
typedef Uint8ClampedArray = snow.api.buffers.Uint8ClampedArray;
#elseif lime
typedef Uint8ClampedArray = lime.utils.Uint8ClampedArray;
#elseif nme
typedef Uint8ClampedArray = nme.utils.Uint8ClampedArray;
#elseif hxsdl
// ...
#elseif js
typedef Uint8ClampedArray = js.html.Uint8ClampedArray;
#else
typedef Uint8ClampedArray = haxe.io.Uint8ClampedArray;
#end
