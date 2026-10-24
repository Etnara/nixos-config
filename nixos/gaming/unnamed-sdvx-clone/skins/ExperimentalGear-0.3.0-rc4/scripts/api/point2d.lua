---@class CPoint2D
Point2D = {
    ---Create a Point2D instance
    ---@param x? number # default 0.0
    ---@param y? number # default 0.0
    ---@return Point2D
    new = function(x, y)
        ---@class Point2D : CPoint2D
        ---@field x number
        ---@field y number
        local o = {
            x = x + .0 or .0,
            y = y + .0 or .0,
        }

        setmetatable(o, Point2D)
        return o
    end
}

Point2D.__index = Point2D
Point2D.ZERO = Point2D.new(0, 0)

function Point2D:coords()
    ---@cast self Point2D

    return self.x, self.y
end
