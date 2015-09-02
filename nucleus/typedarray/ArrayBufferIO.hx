package nucleus.typedarray;

#if snow
typedef ArrayBufferIO = snow.api.buffers.ArrayBufferIO;
#elseif lime
typedef ArrayBufferIO = lime.utils.ArrayBufferIO;
#elseif nme
typedef ArrayBufferIO = nme.utils.ArrayBufferIO;
#elseif hxsdl
// ...
#elseif js
typedef ArrayBufferIO = js.html.ArrayBufferIO;
#else
typedef ArrayBufferIO = haxe.io.ArrayBufferIO;
#end
