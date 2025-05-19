--Load image
local pixmap = LoadPixmap("Materials/77684-blocks18c_1.jpg")

--Convert to RGBA if not already
if pixmap.format ~= TEXTURE_RGBA then
	pixmap = pixmap:Convert(TEXTURE_RGBA)
end

--Let's make some changes :D
pixmap:CopyRect(0,0,256,256,pixmap,256,256)

--Save uncompressed DDS file
SaveTexture("MODIFIED.dds", TEXTURE_2D, {pixmap}, 1, SAVE_DEFAULT)

--Convert to compressed format
pixmap = pixmap:Convert(TEXTURE_BC1)

--We specify blocks, not pixels. Blocks are 4x4 squares.
pixmap:CopyRect(0,0,64,64,pixmap,64,64)

--Save
SaveTexture("COMPRESSED+MODIFIED.dds", TEXTURE_2D, {pixmap}, 1, SAVE_DEFAULT)
