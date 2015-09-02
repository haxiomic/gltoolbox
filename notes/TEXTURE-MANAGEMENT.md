Easy way to enable/change ANIOSTROPY



SOLVED
Regarding Units:
although each unit can hold two textures, TEXTURE_2D or TEXTURE_CUBE_MAP
you can't use both a TEXTURE_2D and a CUBE_MAP on a texture unit AT THE SAME TIME in a shader.
-> to avoid issues this feature isn't used; each texture is given its own slot instead


SOLVED
what about 
	MAX_VERTEX_TEXTURE_IMAGE_UNITS
	MAX_TEXTURE_IMAGE_UNITS
	 ! MAX_COMBINED_TEXTURE_IMAGE_UNITS

does texture manager need to account for this or are the slots unaffected?
	"The number of textures that can be bound to OpenGL is not 32 or 16. It is not what you get with glGetIntegerv(GL_MAX_TEXTURE_IMAGE_UNITS, &texture_units);. That function retrieves the number of textures that can be accessed by the fragment shader."
	GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS
	only 50% have >=32, the rest are less, so if it affects what slots can be bound, it's important!
	(minimum 8)

yes, we need to somehow set the index wrap at MAX_COMBINED_TEXTURE_IMAGE_UNITS - 1.
i: 0 ... MAX_COMBINED_TEXTURE_IMAGE_UNITS - 1
	- check every time to see if a limit has been set
	- manually initialize a runtime


------------------------------

SOLVED - leave note in code

what about target?
Each unit/slot can hold two textures, TEXTURE_2D or TEXTURE_CUBE_MAP
! You can't use both a TEXTURE_2D and a CUBE_MAP on a texture unit AT THE SAME TIME.
-> to avoid issues, make sure each texture gets its own unit in spite of target

------------------------------


Track index, wrap around

frame 1
[0, 1, 2, 3, 4]
[a, b, c, d, e] f g h

f g h
[0, 1, 2, 3, 4]
[f, g, h, d, e]

- reset to 0

frame 2
[0, 1, 2, 3, 4]
[a, b, c, d, e]

f g h
[0, 1, 2, 3, 4]
[f, g, h, d, e] 	(no need to unbind d e)

- reset to 0

frame 3
a b c (f g h unbound)
[0, 1, 2, 3, 4]
[a, b, c, d, e]

d e are already bound :)

f g h
[0, 1, 2, 3, 4]
[f, g, h, d, e]


If we use wrap around (w or /w reset) we don't actually need bindGroup because we are insured
that any fatal replacements are maximally separated by max_textures.
We get more optimal behavior by reseting to zero each frame, but this is optional
