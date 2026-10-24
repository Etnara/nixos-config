---@diagnostic disable:missing-return

---@class ShadedMesh
ShadedMesh = {
  BLEND_NORM = 0,
  BLEND_ADD = 1,
  BLEND_MULT = 2,

  PRIM_TRILIST = 0,
  PRIM_TRIFAN = 1,
  PRIM_TRISTRIP = 2,
  PRIM_LINELIST = 3,
  PRIM_LINESTRIP = 4,
  PRIM_POINTLIST = 5,
};

-- Adds a texture that was loaded with `gfx.LoadSharedTexture` to the material that can be used in the shader code
---@param uniformName string
---@param textureName string
function ShadedMesh:AddSharedTexture(uniformName, textureName) end

-- Adds a texture to the material that can be used in the shader code
---@param uniformName string
---@param path string # prepended with `skins/<skin>/textures/`
function ShadedMesh:AddSkinTexture(uniformName, path) end

-- Adds a texture to the material that can be used in the shader code
---@param uniformName string
---@param path string
function ShadedMesh:AddTexture(uniformName, path) end

-- Gets the translation of the mesh
---@return number x, number y, number z
function ShadedMesh:GetPosition() end

-- Gets the rotation (in degrees) of the mesh
---@return number roll, number yaw, number pitch
function ShadedMesh:GetRotation() end

-- Gets the scale of the mesh
---@return number x, number y, number z
function ShadedMesh:GetScale() end

-- Sets the blending mode
---@param mode integer # options also available as fields of the object prefixed with `BLEND`  
-- `Normal` = 0 (default)  
-- `Additive` = 1  
-- `Multiply` = 2  
function ShadedMesh:SetBlendMode(mode) end

-- Sets the geometry data
---@param data table # array of vertices in clockwise order starting from the top left e.g.
-- ```
-- {
--   { { 0, 0 }, { 0, 0 } },
--   { { 50, 0 }, { 1, 0 } },
--   { { 50, 50 }, { 1, 1 } },
--   { { 0, 50 }, { 0, 1 } },
-- }
-- ```
function ShadedMesh:SetData(data) end

-- Sets the material is opaque or non-opaque (default)
---@param opaque boolean
function ShadedMesh:SetOpaque(opaque) end

-- Sets the value of the specified uniform
---@param uniformName string
---@param value number # `float`
function ShadedMesh:SetParam(uniformName, value) end

-- Sets the value of the specified 2d vector uniform
---@param uniformName string
---@param x number # `float`
---@param y number # `float`
function ShadedMesh:SetParamVec2(uniformName, x, y) end

-- Sets the value of the specified 3d vector uniform
---@param uniformName string
---@param x number # `float`
---@param y number # `float`
---@param z number # `float`
function ShadedMesh:SetParamVec3(uniformName, x, y, z) end

-- Sets the value of the specified 4d vector uniform
---@param uniformName string
---@param x number # `float`
---@param y number # `float`
---@param z number # `float`
---@param w number # `float`
function ShadedMesh:SetParamVec4(uniformName, x, y, z, w) end

-- Sets the translation for the mesh  
-- Relative to the screen for `ShadedMesh`  
-- Relative to the center of the crit line for `ShadedMeshOnTrack`
---@param x number
---@param y number
---@param z? number # Default `0`
function ShadedMesh:SetPosition(x, y, z) end

-- Sets the format for geometry data provided by `SetData`
---@param type integer # options also available as fields of the object prefixed with `PRIM`  
-- `TriangleList` = 0 (default)  
-- `TriangleStrip` = 1  
-- `TriangleFan` = 2  
-- `LineList` = 3  
-- `LineStrip` = 4  
-- `PointList` = 5  
function ShadedMesh:SetPrimitiveType(type) end

-- Sets the rotation (in degrees) of the mesh
-- **WARNING:** For `ShadedMesh`, pitch and yaw may clip, rendering portions or the entire mesh invisible
---@param roll number
---@param yaw? number # Default `0`
---@param pitch? number # Default `0`
function ShadedMesh:SetRotation(roll, yaw, pitch) end

-- Sets the scale of the mesh
---@param x number
---@param y number
---@param z? number # Default `0`
function ShadedMesh:SetScale(x, y, z) end

-- Sets the wireframe mode of the object (does not render texture)  
-- Useful for debugging models or geometry shaders
---@param useWireframe boolean
function ShadedMesh:SetWireframe(useWireframe) end

-- Renders the `ShadedMesh` object
function ShadedMesh:Draw() end


---@class ShadedMeshOnTrack : ShadedMesh
---@field BUTTON_TEXTURE_LENGTH number
---@field FXBUTTON_TEXTURE_LENGTH number
---@field TRACK_LENGTH number
ShadedMeshOnTrack = {
};

-- Gets the length of the mesh
---@return number length
function ShadedMeshOnTrack:GetLength() end

-- Sets the y-scale of the mesh based on its length  
-- Useful for creating fake buttons which may have variable length based on duration
---@param length number
function ShadedMeshOnTrack:ScaleToLength(length) end

-- Stops meshes beyond the track from being rendered if `doClip`
---@param doClip boolean
function ShadedMeshOnTrack:SetClipWithTrack(doClip) end

-- Sets the length (in the y-direction relative to the track) of the mesh
---@param length number # Optional constants: `BUTTON_TEXTURE_LENGTH`, `FXBUTTON_TEXTURE_LENGTH`, and `TRACK_LENGTH`
function ShadedMeshOnTrack:SetLength(length) end

-- Uses an existing game mesh
---@param meshName string # Options: `'button'`, `'fxbutton'`, and `'track'`
function ShadedMeshOnTrack:UseGameMesh(meshName) end
