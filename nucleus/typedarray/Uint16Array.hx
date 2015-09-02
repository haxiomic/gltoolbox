package nucleus.typedarray;

#if snow
typedef Uint16Array = snow.api.buffers.Uint16Array;
#elseif lime
typedef Uint16Array = lime.utils.Uint16Array;
#elseif nme
typedef Uint16Array = nme.utils.Uint16Array;
#elseif hxsdl
// ...
#elseif js
typedef Uint16Array = js.html.Uint16Array;
#else
typedef Uint16Array = haxe.io.Uint16Array;
#end
