package nucleus.typedarray;

#if snow
typedef Float64Array = snow.api.buffers.Float64Array;
#elseif lime
typedef Float64Array = lime.utils.Float64Array;
#elseif nme
typedef Float64Array = nme.utils.Float64Array;
#elseif hxsdl
// ...
#elseif js
typedef Float64Array = js.html.Float64Array;
#else
typedef Float64Array = haxe.io.Float64Array;
#end
