(function (console) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Main = function() {
	gltoolbox_gl_GL.context.clearColor(0,1,0,1);
	gltoolbox_gl_GL.context.clear(16384);
	new Float32Array([0,1,0,0,1,1,1,0,1,1,0,0]);
	gltoolbox_GPU.compileShaders("\n\t\t\tattribute vec2 position;\n\t\t\tvoid main(){\n\t\t\t\tgl_Position = vec4(position.xy, 0.0, 1.0);\n\t\t\t}\n\t\t","\n\t\t\tvoid main(){\n\t\t\t\tgl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);\n\t\t\t}\n\t\t");
};
Main.main = function() {
	var document = window.document;
	document.body.style.padding = "0";
	document.body.style.margin = "0";
	var canvas = document.createElement("canvas");
	var tmp;
	var x = window.innerWidth * .95;
	tmp = x | 0;
	canvas.width = tmp;
	canvas.height = window.innerHeight;
	canvas.style.display = "block";
	canvas.style.margin = "0 auto";
	document.body.appendChild(canvas);
	gltoolbox_gl_GL.context = canvas.getContext("webgl");
	var m = new Main();
	var tmp1;
	var frameLoop1 = null;
	frameLoop1 = function(time) {
		m.render(time);
		window.requestAnimationFrame(frameLoop1);
	};
	tmp1 = frameLoop1;
	var frameLoop = tmp1;
	window.requestAnimationFrame(frameLoop);
};
Main.prototype = {
	render: function(time) {
	}
};
var gltoolbox_GPU = function() { };
gltoolbox_GPU.compileShaders = function(geometryShaderSrc,pixelShaderSrc) {
	var geometryShader = gltoolbox_gl_GL.context.createShader(35633);
	gltoolbox_gl_GL.context.shaderSource(geometryShader,geometryShaderSrc);
	gltoolbox_gl_GL.context.compileShader(geometryShader);
	if(gltoolbox_gl_GL.context.getShaderParameter(geometryShader,35713) == 0) {
		gltoolbox_gl_GL.context.deleteShader(geometryShader);
		throw new js__$Boot_HaxeError("Geometry shader error: " + gltoolbox_gl_GL.context.getShaderInfoLog(geometryShader));
	}
	var pixelShader = gltoolbox_gl_GL.context.createShader(35632);
	gltoolbox_gl_GL.context.shaderSource(pixelShader,pixelShaderSrc);
	gltoolbox_gl_GL.context.compileShader(pixelShader);
	if(gltoolbox_gl_GL.context.getShaderParameter(pixelShader,35713) == 0) {
		gltoolbox_gl_GL.context.deleteShader(pixelShader);
		throw new js__$Boot_HaxeError("Pixel shader error: " + gltoolbox_gl_GL.context.getShaderInfoLog(pixelShader));
	}
	var program = gltoolbox_gl_GL.context.createProgram();
	gltoolbox_gl_GL.context.attachShader(program,geometryShader);
	gltoolbox_gl_GL.context.attachShader(program,pixelShader);
	gltoolbox_gl_GL.context.linkProgram(program);
	if(gltoolbox_gl_GL.context.getProgramParameter(program,35714) == 0) {
		gltoolbox_gl_GL.context.detachShader(program,geometryShader);
		gltoolbox_gl_GL.context.detachShader(program,pixelShader);
		gltoolbox_gl_GL.context.deleteShader(geometryShader);
		gltoolbox_gl_GL.context.deleteShader(pixelShader);
		throw new js__$Boot_HaxeError(gltoolbox_gl_GL.context.getProgramInfoLog(program));
	}
	return program;
};
var gltoolbox_gl_GL = function() { };
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
});
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
