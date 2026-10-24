local util = require("common.util")

---@class CColorRGBA
ColorRGBA = {
    ---Create a new Color instance
    ---@param r integer # red or monochrome value
    ---@param g? integer # green value
    ---@param b? integer # blue value
    ---@param a? integer # alpha value, default 255
    ---@return ColorRGBA
    new = function (r, g , b, a)
        ---@class ColorRGBA : CColorRGBA
        ---@field r integer
        ---@field g integer
        ---@field b integer
        ---@field a integer
        local o = {
            r = r or 0,
            g = g or r,
            b = b or r,
            a = a or 255,
        }

        setmetatable(o, ColorRGBA)
        return o
    end,

    ---Mix two colors
    ---@param color1 ColorRGBA
    ---@param color2 ColorRGBA
    ---@param factor number
    ---@return ColorRGBA
    mix = function (color1, color2, factor)
        local r = math.floor(util.mix(color1.r, color2.r, factor))
        local g = math.floor(util.mix(color1.g, color2.g, factor))
        local b = math.floor(util.mix(color1.b, color2.b, factor))
        local a = math.floor(util.mix(color1.a, color2.a, factor))
        return ColorRGBA.new(r, g, b, a)
    end
}

ColorRGBA.__index = ColorRGBA
ColorRGBA.BLACK = ColorRGBA.new(0)
ColorRGBA.GREY = ColorRGBA.new(128)
ColorRGBA.WHITE = ColorRGBA.new(255)
ColorRGBA.RED = ColorRGBA.new(255, 0, 0)
ColorRGBA.GREEN = ColorRGBA.new(0, 255, 0)
ColorRGBA.BLUE = ColorRGBA.new(0, 0, 255)
ColorRGBA.YELLOW = ColorRGBA.new(255, 255, 0)
ColorRGBA.CYAN = ColorRGBA.new(0, 255, 255)
ColorRGBA.MAGENTA = ColorRGBA.new(255, 0, 255)

---Split to components
---@return integer # red
---@return integer # green
---@return integer # blue
---@return integer # alpha
function ColorRGBA:components()
    ---@cast self ColorRGBA

    return self.r, self.g, self.b, self.a
end

---Split to components scaled to [0.0, 1.0]
---@return number # red
---@return number # green
---@return number # blue
---@return number # alpha
function ColorRGBA:componentsFloat()
    ---@cast self ColorRGBA
    local scale = 255

    return self.r / scale, self.g / scale, self.b / scale, self.a / scale
end
