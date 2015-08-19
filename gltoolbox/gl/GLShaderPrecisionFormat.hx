package gltoolbox.gl;

#if snow || lime || nme || hxsdl
typedef GLShaderPrecisionFormat = {
    var rangeMin:Int;
    var rangeMax:Int;
    var precision:Int;
}
#elseif js
typedef GLShaderPrecisionFormat = js.html.webgl.ShaderPrecisionFormat;
#end