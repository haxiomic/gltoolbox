package gltoolbox.typedarray;

#if snow
typedef DataView = snow.api.buffers.DataView;
#elseif lime
typedef DataView = lime.utils.DataView;
#elseif nme
typedef DataView = nme.utils.DataView;
#elseif hxsdl
// ...
#elseif js
typedef DataView = js.html.DataView;
#end
