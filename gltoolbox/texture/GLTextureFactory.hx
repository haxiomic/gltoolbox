//@! temporary class, to be replaced by (:Texture).clone();

package gltoolbox.texture;

import gltoolbox.gl.GLTexture;

typedef GLTextureFactory = Int->Int->GLTexture; //(width, height):GLTexture