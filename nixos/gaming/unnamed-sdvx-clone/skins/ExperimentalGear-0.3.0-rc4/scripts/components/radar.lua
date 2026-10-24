--[[
S2 song attribute radar component
Original code thanks to RealFD, he's a real homie
]]

require("common.globals")
require("api.point2d")
require("api.color")

local Dim = require("common.dimensions")
local Util = require("common.util")

Dim.updateResolution()

local RADAR_PURPLE = ColorRGBA.new(238, 130, 238)
local RADAR_MAGENTA = ColorRGBA.new(191, 70, 235)
local RADAR_GREEN = ColorRGBA.new(0, 255, 100)

local maxScaleFactor = 1.8

---@param p1 Point2D
---@param p2 Point2D
---@param width number
---@param color ColorRGBA
local function drawLine(p1, p2, width, color)
    gfx.BeginPath()
    gfx.MoveTo(p1:coords())
    gfx.LineTo(p2:coords())
    gfx.StrokeColor(color:components())
    gfx.StrokeWidth(width)
    gfx.Stroke()
end

---@param pos Point2D
---@param text string
---@param outlineWidth number
---@param color ColorRGBA
local function renderOutlinedText(pos, text, outlineWidth, color)
    local x, y = pos:coords()

    local dimColor = color:mix(ColorRGBA.BLACK, 0.8)
    gfx.FillColor(dimColor:components());
    gfx.Text(text, x - outlineWidth, y + outlineWidth);
    gfx.Text(text, x - outlineWidth, y - outlineWidth);
    gfx.Text(text, x + outlineWidth, y + outlineWidth);
    gfx.Text(text, x + outlineWidth, y - outlineWidth);

    gfx.FillColor(color:components());
    gfx.Text(text, x, y);
end

---@param pos Point2D
---@param graphdata table
local function drawDebugText(pos, graphdata)
    local color = ColorRGBA.WHITE
    gfx.Save()
    gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_CENTER)
    --renderOutlinedText(x, 20, '"' .. txtFilePath .. '"', 1, 255, 255, 255)
    renderOutlinedText(pos, "NOTES = " .. graphdata.notes, 1, color)
    renderOutlinedText(pos, "PEAK = " .. graphdata.peak, 1, color)
    renderOutlinedText(pos, "TSUMAMI = " .. graphdata.tsumami, 1, color)
    renderOutlinedText(pos, "TRICKY = " .. graphdata.tricky, 1, color)
    renderOutlinedText(pos, "ONE-HAND = " .. graphdata.onehand, 1, color)
    renderOutlinedText(pos, "HAND-TRIP = " .. graphdata.handtrip, 1, color)
    --renderOutlinedText(pos, "NOTES (Relative) = " .. graphdata.notes_relative, 1, color)
    --renderOutlinedText(pos, "TOTAL-MESURES = " .. graphdata.measures, 1, color)
    gfx.Restore()
end

---@class CRadarAttributes
RadarAttributes = {
    ---Create RadarAttributes instance
    ---@param text? string # default ""
    ---@param offset? Point2D # default (0, 0)
    ---@param color? ColorRGBA # default BLACK
    ---@param align? integer # gfx.TEXT_ALIGN_<...> values, default gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_BASELINE
    ---@return RadarAttributes
    new = function (text, offset, color, align)
        ---@class RadarAttributes
        ---@field text string
        ---@field offset Point2D
        ---@field color ColorRGBA
        local o = {
            text = text or "",
            offset = offset or Point2D.ZERO,
            color = color or ColorRGBA.BLACK,
            align = align or gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_BASELINE
        }

        setmetatable(o, RadarAttributes)
        return o
    end
}
RadarAttributes.__index = RadarAttributes


---@class CRadar
Radar = {
    ---@type RadarAttributes[][]
    ATTRIBUTES = {
        {RadarAttributes.new("notes", Point2D.new(0, 0), ColorRGBA.CYAN, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_BOTTOM),},
        {RadarAttributes.new("peak", Point2D.new(0, 0), ColorRGBA.RED, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_BOTTOM), },
        {RadarAttributes.new("tsumami", Point2D.new(0, 0), RADAR_PURPLE, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_TOP),},
        {RadarAttributes.new("tricky", Point2D.new(0, 0), ColorRGBA.YELLOW, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_TOP),},
        {
            RadarAttributes.new("hand", Point2D.new(0, 0), RADAR_MAGENTA, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_TOP),
            RadarAttributes.new("trip", Point2D.new(5, 16), RADAR_MAGENTA, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_TOP),
        },
        {
            RadarAttributes.new("one", Point2D.new(6, -16), RADAR_GREEN, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_BOTTOM),
            RadarAttributes.new("hand", Point2D.new(0, 0), RADAR_GREEN, gfx.TEXT_ALIGN_CENTER + gfx.TEXT_ALIGN_BOTTOM),
        }
    },
    RADIUS = 100.0,

    ---Create Radar instance
    ---@param pos Point2D
    ---@param radius? number
    ---@return Radar
    new = function (pos, radius)
        ---@class Radar : CRadar
        local o = {
            _graphdata = {
                notes =  0,
                peak =  0,
                tsumami = 0,
                tricky = 0,
                handtrip = 0,
                onehand = 0,
            },
            _hexagonMesh = gfx.CreateShadedMesh("radar"),
            _outlineVertices = {},
            _attributePositions = {}, ---@type Point2D[][]
            _angleStep = (2 * math.pi) / #Radar.ATTRIBUTES, -- 360° / no. attributes, in radians
            _initRotation = math.pi / 2, -- 90°, in radians
            pos = pos or Point2D.ZERO,
            scale = radius and radius / Radar.RADIUS or 1.0,
        }

        local sides = #Radar.ATTRIBUTES

        local outlineRadius = Radar.RADIUS
        local attributeRadius = Radar.RADIUS + 30

        for i = 0, sides - 1 do
            local attrIdx = i + 1
            local angle = i * o._angleStep - o._initRotation
            local cosAngle = math.cos(angle)
            local sinAngle = math.sin(angle)
            -- cache outline vertices
            table.insert(o._outlineVertices, Point2D.new(outlineRadius * cosAngle, outlineRadius * sinAngle))
            -- cache attribute positions
            table.insert(o._attributePositions, {})
            for j = 1, #Radar.ATTRIBUTES[attrIdx] do
                local attr = Radar.ATTRIBUTES[attrIdx][j]
                local attributePos = Point2D.new(attributeRadius * cosAngle, attributeRadius * sinAngle)
                attributePos.x = attributePos.x + attr.offset.x
                attributePos.y = attributePos.y + attr.offset.y
                table.insert(o._attributePositions[attrIdx], j, attributePos)
            end
        end

        setmetatable(o, Radar)
        return o
    end,
}
Radar.__index = Radar

---@param w number
---@param color ColorRGBA
function Radar:drawOutline(w, color)
    ---@cast self Radar

    for i = 1, #self._outlineVertices do
        local j = i % #self._outlineVertices + 1
        drawLine(self._outlineVertices[i], self._outlineVertices[j], w, color)
    end
end

---@param color ColorRGBA
---@param ticks? integer
function Radar:drawRadialTicks(color, ticks)
    ---@cast self Radar

    ticks = ticks or 3

    gfx.Save()
    gfx.StrokeColor(color:components())

    for i, vertex in ipairs(self._outlineVertices) do
        gfx.BeginPath()
        gfx.MoveTo(0, 0)
        gfx.LineTo(vertex.x, vertex.y)
        gfx.Stroke()

        local lineLength = math.sqrt(vertex.x * vertex.x + vertex.y * vertex.y)
        local tinyLineLength = 10

        local tinyLineAngle = math.atan(vertex.y / vertex.x)
        if vertex.x < 0 then
            tinyLineAngle = tinyLineAngle + math.pi
        end

        local halfTinyLineLength = tinyLineLength / 2

        for j = 1, ticks do
            local distanceFromCenter = j * lineLength / (ticks + 1)     -- Adjusted for 3 middle lines

            local offsetX = distanceFromCenter * (vertex.x / lineLength)
            local offsetY = distanceFromCenter * (vertex.y / lineLength)

            local endX = halfTinyLineLength * math.cos(tinyLineAngle - math.pi / 2)     -- Rotate by -90 degrees
            local endY = halfTinyLineLength * math.sin(tinyLineAngle - math.pi / 2)     -- Rotate by -90 degrees

            local offsetX2 = halfTinyLineLength * math.cos(tinyLineAngle + math.pi / 2)
            local offsetY2 = halfTinyLineLength * math.sin(tinyLineAngle + math.pi / 2)

            gfx.BeginPath()
            gfx.MoveTo(offsetX - offsetX2, offsetY - offsetY2)
            gfx.LineTo(endX + offsetX + offsetX2 + offsetX2, endY + offsetY + offsetY2 + offsetY2)
            gfx.Stroke()
        end
    end

    gfx.Restore()
end

---@param fillColor ColorRGBA
function Radar:drawBackground(fillColor)
    ---@cast self Radar

    gfx.Save()

    gfx.BeginPath()
    gfx.MoveTo(self._outlineVertices[1].x, self._outlineVertices[1].y)
    for i = 2, #self._outlineVertices do
        gfx.LineTo(self._outlineVertices[i].x, self._outlineVertices[i].y)
    end
    gfx.ClosePath()

    gfx.FillColor(fillColor:components())
    gfx.Fill()

    gfx.Restore()
end

function Radar:drawAttributes()
    ---@cast self Radar

    gfx.Save()

    gfx.LoadSkinFont("contb.ttf")
    gfx.FontSize(21)
    for i = 1, #self._attributePositions do
        local attrPos = self._attributePositions[i]
        for j = 1, #attrPos do
            local pos = attrPos[j]
            local attr = Radar.ATTRIBUTES[i][j]
            gfx.TextAlign(attr.align)
            renderOutlinedText(pos, string.upper(attr.text), 1, attr.color)
        end
    end

    gfx.Restore()
end

---Draw shaded radar mesh
---
---Bug: ForceRender resets every transformation, you need to re-setup view transform afterwards.
---ForceRender also resets the gfx stack, USC will crash if you try to call gfx.Restore(), 
---make sure the gfx stack is clean before calling radar:drawRadarMesh()
function Radar:drawRadarMesh()
    ---@cast self Radar

    local scaleFact = {
        self._graphdata.notes,
        self._graphdata.peak,
        self._graphdata.tsumami,
        self._graphdata.tricky,
        self._graphdata.handtrip,
        self._graphdata.onehand,
    }

    local colorMax = ColorRGBA.new(255, 12, 48, 230)  -- magenta-ish
    local colorCenter = ColorRGBA.new(112, 119, 255, 230)  -- light blue-ish purple

    -- Calculate the maximum size based on the constraint
    local maxSize = self.RADIUS * self.scale
    local maxLineLength = maxSize * maxScaleFactor
    self._hexagonMesh:SetParam("maxSize", maxLineLength + .0)

    -- Set the color of the hexagon
    self._hexagonMesh:SetParamVec4("colorMax", colorMax:componentsFloat())
    self._hexagonMesh:SetParamVec4("colorCenter", colorCenter:componentsFloat())

    -- Set the primitive type to triangles
    self._hexagonMesh:SetPrimitiveType(self._hexagonMesh.PRIM_TRIFAN)

    -- Calculate the vertices of the hexagon
    local sides = #Radar.ATTRIBUTES

    local vertices = {}
    table.insert(vertices, {{0, 0}, {0, 0}})
    for i = 0, sides do
        local j = i % sides + 1
        local angle = i * self._angleStep - self._initRotation

        --local angle = math.rad(60 * (i-1)) + rotationAngle
        local scale = scaleFact[j]
        local lineLength = maxSize * scale
        local px = lineLength * math.cos(angle)
        local py = lineLength * math.sin(angle)
        table.insert(vertices, {{px, py}, {0, 0}})
    end

    -- Set the hexagon's vertices
    self._hexagonMesh:SetData(vertices)
    self._hexagonMesh:Draw()

    -- YOU! You are the reason for all my pain!
    gfx.ForceRender()
end

--NOTE: THIS IS BUGGY, ForceRender fucks up so many things, call the individual draw functions at top level
function Radar:drawGraph()
    ---@cast self Radar

    game.Log("Radar:drawGraph() SHOULD NOT BE CALLED", game.LOGGER_WARNING)

    gfx.Save()
    gfx.Reset()
    gfx.ResetScissor()

    Dim.updateResolution()
    Dim.transformToScreenSpace()

    gfx.FontSize(28)
    gfx.Translate(self.pos.x, self.pos.y)
    gfx.Scale(self.scale, self.scale)

    local strokeColor = ColorRGBA.new(255, 255, 255, 100)
    local fillColor = ColorRGBA.new(0, 0, 0, 191)

    self:drawBackground(fillColor)
    self:drawOutline(3, strokeColor)
    self:drawRadarMesh()
    self:drawRadialTicks(strokeColor)
    self:drawAttributes()

    local pos = Point2D.new(self.pos:coords())
    pos.y = pos.y - self.RADIUS
    --drawDebugText(pos, self._graphdata)

    gfx.Restore()

    --NOTE: Bug workaround: forcerender resets every transformation, re-setup view transform
    Dim.transformToScreenSpace()
end

---Compute radar attribute values from ksh
---@param info string # chart directory path
---@param dif string # chart name without extension
function Radar:updateGraph(info, dif)
    ---@cast self Radar

    --local pattern = "(.*[\\/])"
    --local extractedSubstring = info:match(pattern)
    --local txtFilePath = extractedSubstring .. "radar\\" .. dif .. ".txt"

    --local song = io.open(txtFilePath, "r")
    local fullPath = info.."/"..dif..".ksh"
    local song = io.open(fullPath)
    game.Log('Reading chart data from "'..fullPath..'"', game.LOGGER_DEBUG)
    game.Log(song and "file open" or "file not found", game.LOGGER_DEBUG)
    if song then
        local chartData = song:read("*all")
        song:close()

        local notesCount, knobCount, oneHandCount, handTripCount = 0, 0, 0, 0
        local chartLineCount = 0
        local notesValue = 0
        local peakValue = 0
        local tsumamiValue = 0
        local trickyValue = 0
        local totalMeasures = 0

        local lastNotes = {}
        local lastFx = {}
        local measureLength = 0

        ---@cast chartData string
        for line in chartData:gmatch("[^\r\n]+") do
            -- <bt-lanes x 4>|<fx-lanes x 2>|<laser-lanes x 2><lane-spin (optional)>

            --game.Log(line, game.LOGGER_DEBUG)

            local patternBt = "([012][012][012][012])"
            local patternFx = "([012ABDFGHIJKLPQSTUVWX][012ABDFGHIJKLPQSTUVWX])"
            local patternLaser = "([%-:%dA-Za-o][%-:%dA-Za-o])"
            local patternLaneSpin = "([@S][%(%)<>]%d+)" -- optional
            local pattern = patternBt.."|"..patternFx.."|"..patternLaser

            -- match line format

            local noteType, fxType, laserType = line:match(pattern)
            local laneSpin = line:match(patternLaneSpin)

            if noteType and fxType and laserType then
                chartLineCount = chartLineCount + 1

                -- convert strings to array, to be easily indexable

                noteType = {noteType:match("([012])([012])([012])([012])")}
                fxType = {fxType:match("([012ABDFGHIJKLPQSTUVWX])([012ABDFGHIJKLPQSTUVWX])")}
                laserType = {laserType:match("([%-:%dA-Za-o])([%-:%dA-Za-o])")}

                ---@cast noteType string[]
                ---@cast fxType string[]
                ---@cast laserType string[]

                -- parse notes

                local function isNewNote(idx, note)
                    if note == "2" and lastNotes[idx] ~= note then
                        -- a new hold note
                        return true
                    end
                    if note == "1" then
                        -- a chip
                        return true
                    end
                end
                for noteIdx, note in ipairs(noteType) do
                    if isNewNote(noteIdx, note) then
                        notesCount = notesCount + 1
                    end
                end

                -- parse fx

                local function isNewFx(idx, fx)
                    if fx:match("[1ABDFGHIJKLPQSTUVWX]") and lastFx[idx] ~= fx then
                        -- a new hold note
                        return true
                    end
                    if fx == "2" then
                        -- a chip
                        return true
                    end
                end
                for fxIdx, fx in ipairs(fxType) do
                    if isNewFx(fxIdx, fx) then
                        notesCount = notesCount + 1
                    end
                end

                -- parse laser

                for _, laser in ipairs(laserType) do
                    if laser ~= "-" then
                        knobCount = knobCount + 1
                    end
                end

                -- figure out one-handed notes (there's a BT or FX while a hand is manipulating a knob)
                -- also try to figure out cross-handed notes (one-handed notes, but on the same side as knob)

                local function countBtFx()
                    local count = 0
                    for noteIdx, note in ipairs(noteType) do
                        if isNewNote(noteIdx, note) then
                            count = count + 1
                        end
                    end
                    for fxIdx, fx in ipairs(fxType) do
                        if isNewFx(fxIdx, fx) then
                            count = count + 1
                        end
                    end
                    return count
                end
                ---@param side "left"|"right"
                local function countSide(side)
                    local count = 0
                    local notes = {}
                    local fx = ""
                    if side == "left" then
                        notes = {noteType[1], noteType[2]}
                        fx = fxType[1]
                        if isNewFx(1, fx) then
                            count = count + 1
                        end
                    elseif side == "right" then
                        notes = {noteType[3], noteType[4]}
                        fx = fxType[2]
                        if isNewFx(2, fx) then
                            count = count + 1
                        end
                    else
                        game.Log("countSide: Invalid side parameter", game.LOGGER_ERROR)
                        return 0
                    end
                    for noteIdx, note in ipairs(notes) do
                        if isNewNote(noteIdx, note) then
                            count = count + 1
                        end
                    end
                    return count
                end
                if laserType[1] ~= "-" and laserType[2] == "-" then
                    oneHandCount = oneHandCount + countBtFx()
                    handTripCount = handTripCount + countSide("left")
                end
                if laserType[1] == "-" and laserType[2] ~= "-" then
                    oneHandCount = oneHandCount + countBtFx()
                    handTripCount = handTripCount + countSide("right")
                end

                lastNotes = noteType
                lastFx = fxType

                measureLength = measureLength + 1
            end

            if line == "--" then
                -- end of measure
                measureLength = math.max(1, measureLength)

                local relativeMeasureLength = measureLength / 192

                -- calculate peak density
                local peak = (notesCount / 6) / relativeMeasureLength
                peakValue = math.max(peakValue, peak)
                --[[
                local debuglog = {
                    measureLength = measureLength,
                    notesCount = notesCount,
                    relativeMeasureLength = relativeMeasureLength,
                    peak = peak,
                }
                for k, v in pairs(debuglog) do
                    game.Log(k..": "..v, game.LOGGER_DEBUG)
                end                    
                ]]

                -- cumulate "time" spent operating the knobs
                local tsumami = (knobCount / 2) / relativeMeasureLength
                tsumamiValue = tsumamiValue + tsumami

                measureLength = 0
                notesCount = 0

                -- cumulate peak values (used to average notes over the length of the song)
                notesValue = notesValue + peak

                totalMeasures = totalMeasures + 1
            end

            local beat = line:match("beat=(%d+/%d+)")
            if beat then
                beat = {beat:match("(%d+)/(%d+)")}
            end

            --BUG: This is not correct, it needs to account for effect length
            local function isTricky()
                local tricks = {
                    "beat",
                    "stop",
                    "zoom_top",
                    "zoom_bottom",
                    "zoom_side",
                    "center_split",
                }
                return Util.any(tricks, function(e) return line:match("e") end)
            end
            if laneSpin or isTricky() then
                trickyValue = trickyValue + 1
            end
        end

        local graphValues = {
            notes = notesValue / totalMeasures,
            peak = peakValue,
            tsumami = tsumamiValue / totalMeasures,
            tricky = trickyValue,
            handtrip = handTripCount,
            onehand = oneHandCount,
        }

        game.Log("graphValues", game.LOGGER_DEBUG)
        for k,v in pairs(graphValues) do
            game.Log(k..": "..v, game.LOGGER_DEBUG)
        end

        local calibration = {
            notes = 10,
            peak = 48,
            tsumami = 20000,
            tricky = 128,
            handtrip = 300,
            onehand = 300,
        }

        for key, factor in pairs(calibration) do
            -- Apply the scaling factor to each value
            self._graphdata[key] = graphValues[key] / factor

            -- Limit to maximum scale factor
            self._graphdata[key] = math.min(self._graphdata[key], maxScaleFactor)
        end

        game.Log("_graphdata", game.LOGGER_DEBUG)
        for k,v in pairs(self._graphdata) do
            game.Log(k..": "..v, game.LOGGER_DEBUG)
        end
    end
end

return Radar
