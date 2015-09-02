(function (console) { "use strict";
var Main = function() {
	nucleus_gl_GL.context.clearColor(1,0,0,1);
	nucleus_gl_GL.context.clear(16384);
	this.vertices = new nucleus_buffer_Buffer(new Float32Array([0,1,0,0,1,1,1,0,1,1,0,0]));
};
Main.main = function() {
	var document = window.document;
	document.body.style.padding = "0";
	document.body.style.margin = "0";
	var canvas = document.createElement("canvas");
	canvas.width = window.innerWidth;
	canvas.height = window.innerHeight;
	canvas.style.display = "block";
	canvas.style.margin = "0 auto";
	document.body.appendChild(canvas);
	nucleus_gl_GL.context = canvas.getContext("webgl");
	var m = new Main();
	var tmp;
	var frameLoop1 = null;
	frameLoop1 = function(time) {
		m.render(time);
		window.requestAnimationFrame(frameLoop1);
	};
	tmp = frameLoop1;
	var frameLoop = tmp;
	window.requestAnimationFrame(frameLoop);
};
Main.prototype = {
	render: function(time) {
	}
};
var nucleus_buffer_Buffer = function(data,usage) {
	if(usage == null) usage = 35044;
	this.data = data;
	this.usage = usage;
};
var nucleus_gl_GL = function() { };
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
