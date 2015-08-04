package gltoolbox.typedarray;

#if snow
typedef ArrayBufferView = snow.api.buffers.ArrayBufferView;
#elseif lime
typedef ArrayBufferView = lime.utils.ArrayBufferView;
#elseif nme
typedef ArrayBufferView = nme.utils.ArrayBufferView;
#elseif hxsdl
// ...
#elseif js
typedef ArrayBufferView = js.html.ArrayBufferView;
#end