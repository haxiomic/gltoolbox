package gltoolbox;

import lime.graphics.opengl.GL;
import lime.graphics.GLRenderContext;
import lime.graphics.opengl.GLBuffer;
import lime.utils.Float32Array;

class GeometryTools{
    static public inline function createClipSpaceQuad(gl:GLRenderContext, drawMode:Int = GL.TRIANGLE_STRIP):GLBuffer{
        return createQuad(gl, -1, -1, 1, 1, drawMode);
    }

    static public inline function createQuad(
        gl:GLRenderContext, 
        originX:Float = 0,
        originY:Float = 0,
        width:Float   = 1,
        height:Float  = 1,
        drawMode:Int  = GL.TRIANGLE_STRIP):GLBuffer{
        var quad = gl.createBuffer();
        var vertices = new Array<Float>();
        switch (drawMode) {
            case GL.TRIANGLE_STRIP, GL.TRIANGLES:
                vertices = [//anti-clockwise triangle strip
                    originX,        originY+height,     //  0---2
                    originX,        originY,            //  |  /|
                    originX+width,  originY+height,     //  | / |
                    originX+width,  originY,            //  1---3
                    //TRIANGLE_STRIP builds triangles with the pattern, v0, v1, v2 | v2, v1, v3
                    //by default, anti-clockwise triangles are front-facing 
                ];
                if(drawMode == GL.TRIANGLES){
                    vertices = vertices.concat([        //  *---4
                        originX+width,  originY+height, //  |  /|
                        originX,        originY,        //  | / |
                    ]);                                 //  5---*
                }
            case GL.TRIANGLE_FAN:
                vertices = [//anti-clockwise triangle strip
                    originX,        originY+height,     //  0---3
                    originX,        originY,            //  |\  |
                    originX+width,  originY,            //  | \ |
                    originX+width,  originY+height,     //  1---2
                    //TRIANGLE_STRIP builds triangles with the pattern, v0, v1, v2 | v2, v1, v3
                    //by default, anti-clockwise triangles are front-facing 
                ];
        }
        gl.bindBuffer(gl.ARRAY_BUFFER, quad);
        gl.bufferData(gl.ARRAY_BUFFER, new Float32Array(vertices), gl.STATIC_DRAW);
        gl.bindBuffer(gl.ARRAY_BUFFER, null);
        return quad;
    }
}