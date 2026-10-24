local MAJOR = 0
local MINOR = 3
local PATCH = 0

local function getLongVersion()
    return "USC:E:G:S:" .. MAJOR .. MINOR .. PATCH
end

---Get version string
---@return string
local function getVersion()
    return table.concat({MAJOR, MINOR, PATCH}, ".")
end

return {
    MAJOR = MAJOR,
    MINOR = MINOR,
    PATCH = PATCH,
    getLongVersion = getLongVersion,
    getVersion = getVersion
}
