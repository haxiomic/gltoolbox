package nucleus.typedarray;

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
#else
typedef DataView = haxe.io.DataView;
#end
