(function (console) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var gltoolbox_object_Object3D = function() {
	var tmp;
	var this1;
	this1 = new Float32Array(16);
	gltoolbox_math__$Mat4_Mat4_$Impl_$.set(this1,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
	tmp = this1;
	this._localMatrix = gltoolbox_math__$Mat4_Mat4_$Impl_$.identity(tmp);
	var tmp1;
	var this2;
	this2 = new Float32Array(16);
	gltoolbox_math__$Mat4_Mat4_$Impl_$.set(this2,1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1);
	tmp1 = this2;
	this._worldMatrix = tmp1;
	this.userMatrix = null;
	this.rotation = new gltoolbox_math__$Euler_EulerClass(0,0,0,"XYZ");
	var tmp2;
	var y = 1;
	var z = 1;
	var this3;
	this3 = new Float32Array(3);
	if(y == null) y = 1;
	if(z == null) z = y;
	gltoolbox_math__$Vec3_Vec3_$Impl_$.set(this3,1,y,z);
	tmp2 = this3;
	this.scale = tmp2;
	this.children = [];
	this._worldMatrixNeedsUpdate = true;
	this.localMatrixNeedsUpdate = true;
};
gltoolbox_object_Object3D.__name__ = true;
gltoolbox_object_Object3D.prototype = {
	__class__: gltoolbox_object_Object3D
};
var gltoolbox_object_Mesh = function(geometry,shader) {
	gltoolbox_object_Object3D.call(this);
	this.geometry = geometry;
	this.shader = shader;
	this.visible = true;
};
gltoolbox_object_Mesh.__name__ = true;
gltoolbox_object_Mesh.__super__ = gltoolbox_object_Object3D;
gltoolbox_object_Mesh.prototype = $extend(gltoolbox_object_Object3D.prototype,{
	__class__: gltoolbox_object_Mesh
});
var Cube = function() {
	gltoolbox_object_Mesh.call(this,null,null);
};
Cube.__name__ = true;
Cube.__super__ = gltoolbox_object_Mesh;
Cube.prototype = $extend(gltoolbox_object_Mesh.prototype,{
	__class__: Cube
});
var Tri = function() {
	this.prop = "coolio";
	Cube.call(this);
};
Tri.__name__ = true;
Tri.__super__ = Cube;
Tri.prototype = $extend(Cube.prototype,{
	__class__: Tri
});
var Quad = function() {
	Tri.call(this);
};
Quad.__name__ = true;
Quad.__super__ = Tri;
Quad.prototype = $extend(Tri.prototype,{
	__class__: Quad
});
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	var o3d = new gltoolbox_object_Object3D();
	var mesh = new gltoolbox_object_Mesh(null,null);
	var mesh2 = new gltoolbox_object_Mesh(null,null);
	var cube = new Cube();
	var objects = [];
	objects.push(o3d);
	objects.push(mesh);
	objects.push(mesh2);
	objects.push(cube);
	objects.push(new Tri());
	objects.push(new Quad());
	console.log("Method 2");
	var _g = 0;
	while(_g < objects.length) {
		var obj = objects[_g];
		++_g;
		var o = obj;
		var c = o == null?null:js_Boot.getClass(o);
		switch(c) {
		case gltoolbox_object_Mesh:
			console.log("is Mesh, (o:Mesh).visible = " + Std.string(o.visible));
			break;
		case gltoolbox_object_Object3D:
			console.log("is Object3D");
			break;
		case Cube:
			console.log("is Cube");
			break;
		case Tri:
			console.log("is Tri: " + o.prop);
			break;
		case Quad:
			console.log("is Quad");
			break;
		default:
			console.log("is unknown");
		}
	}
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var gltoolbox_geometry_Geometry = function() { };
gltoolbox_geometry_Geometry.__name__ = true;
gltoolbox_geometry_Geometry.prototype = {
	__class__: gltoolbox_geometry_Geometry
};
var gltoolbox_math__$Euler_EulerClass = function(rotationX,rotationY,rotationZ,order) {
	if(order == null) order = "XYZ";
	var tmp;
	var y = rotationY;
	var z = rotationZ;
	var this1;
	this1 = new Float32Array(3);
	if(rotationY == null) y = rotationX;
	if(rotationZ == null) z = y;
	gltoolbox_math__$Vec3_Vec3_$Impl_$.set(this1,rotationX,y,z);
	tmp = this1;
	this.v = tmp;
	if(order != "XYZ") throw new js__$Boot_HaxeError("orders other than XYZ have yet to be tested");
	this.order = order;
};
gltoolbox_math__$Euler_EulerClass.__name__ = true;
gltoolbox_math__$Euler_EulerClass.prototype = {
	__class__: gltoolbox_math__$Euler_EulerClass
};
var gltoolbox_math__$Mat4_Mat4_$Impl_$ = {};
gltoolbox_math__$Mat4_Mat4_$Impl_$.__name__ = true;
gltoolbox_math__$Mat4_Mat4_$Impl_$.set = function(this1,n11,n12,n13,n14,n21,n22,n23,n24,n31,n32,n33,n34,n41,n42,n43,n44) {
	this1[0] = n11;
	this1[4] = n12;
	this1[8] = n13;
	this1[12] = n14;
	this1[1] = n21;
	this1[5] = n22;
	this1[9] = n23;
	this1[13] = n24;
	this1[2] = n31;
	this1[6] = n32;
	this1[10] = n33;
	this1[14] = n34;
	this1[3] = n41;
	this1[7] = n42;
	this1[11] = n43;
	this1[15] = n44;
	return this1;
};
gltoolbox_math__$Mat4_Mat4_$Impl_$.identity = function(this1) {
	this1[0] = 1;
	this1[4] = 0;
	this1[8] = 0;
	this1[12] = 0;
	this1[1] = 0;
	this1[5] = 1;
	this1[9] = 0;
	this1[13] = 0;
	this1[2] = 0;
	this1[6] = 0;
	this1[10] = 1;
	this1[14] = 0;
	this1[3] = 0;
	this1[7] = 0;
	this1[11] = 0;
	this1[15] = 1;
	this1;
	return this1;
};
var gltoolbox_math__$Vec3_Vec3_$Impl_$ = {};
gltoolbox_math__$Vec3_Vec3_$Impl_$.__name__ = true;
gltoolbox_math__$Vec3_Vec3_$Impl_$.set = function(this1,x,y,z) {
	this1[0] = x;
	this1[1] = y;
	this1[2] = z;
	return this1;
};
var gltoolbox_shader_Shader = function() { };
gltoolbox_shader_Shader.__name__ = true;
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else {
		var cl = o.__class__;
		if(cl != null) return cl;
		var name = js_Boot.__nativeClassName(o);
		if(name != null) return js_Boot.__resolveNativeClass(name);
		return null;
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") return null;
	return name;
};
js_Boot.__resolveNativeClass = function(name) {
	return (Function("return typeof " + name + " != \"undefined\" ? " + name + " : null"))();
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
js_Boot.__toStr = {}.toString;
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
