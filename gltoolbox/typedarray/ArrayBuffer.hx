package gltoolbox.typedarray;

#if snow
typedef ArrayBuffer = snow.api.buffers.ArrayBuffer;
#elseif lime
typedef ArrayBuffer = lime.utils.ArrayBuffer;
#elseif nme
typedef ArrayBuffer = nme.utils.ArrayBuffer;
#elseif hxsdl
// ...
#elseif js
typedef ArrayBuffer = js.html.ArrayBuffer;
#end
