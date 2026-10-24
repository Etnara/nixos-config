require("common.globals")
require("common.gameconfig")

local version = require("common.version")
local Dim = require("common.dimensions")
local Num = require("components.numbers")

local BAR_ALPHA = 191

local FOOTER_HEIGHT = 128
local footerY = Dim.design.height - FOOTER_HEIGHT

-- Images
local footerRightImage = gfx.CreateSkinImage("components/bars/footer_right.png", 0)
local timeImage = gfx.CreateSkinImage("components/bars/time.png", 0)
local creditImage = gfx.CreateSkinImage("components/bars/credit.png", 0)
local timeNumbers = Num.load_number_image("components/bars/time_num")
local timeColon = gfx.CreateSkinImage("components/bars/time_colon.png", 0)

-- Animation related
local entryTransitionScale = 0
local entryTransitionFooterYOffset = 0

local legend = {{control = "START", text = "Confirm selection"}, {control = "KNOB", text = "Scroll"}}

local timeOut = tonumber(GameConfig["DemoIdleTime"]) or 0
local demoIdleTime = timeOut
local enableTimer = game.GetSkinSetting("songselect_enableTimer") or false
local freezeTimer = game.GetSkinSetting("songselect_freezeTimer") or -1

local function resetTimer()
    timeOut = demoIdleTime or 0
end

local function set(o)
    o = o or {
        enableTimer=game.GetSkinSetting("songselect_enableTimer") or false,
        freezeTimer=game.GetSkinSetting("songselect_freezeTimer") or -1
    }
    enableTimer = o.enableTimer
    freezeTimer = o.freezeTimer
end

local function drawTimer(time_s, show_minutes)
    if show_minutes then
        gfx.BeginPath()
        local xpos, ypos = Dim.design.width - 500, footerY + 55
        local w, h = gfx.ImageSize(timeImage)
        gfx.ImageRect(xpos, ypos, w, h, timeImage, 1, 0)

        -- Draw minutes:seconds display
        local minutes, seconds = time_s // 60, time_s % 60

        local tens, ones = math.floor(minutes // 10), math.floor(minutes % 10)
        w, h = 90, 90
        xpos, ypos = xpos + 55, footerY - 16
        gfx.BeginPath()
        gfx.ImageRect(xpos, ypos, w, h, timeNumbers[tens + 1], 1, 0)
        gfx.BeginPath()
        gfx.ImageRect(xpos + w, ypos, w, h, timeNumbers[ones + 1], 1, 0)

        xpos = xpos + 2 * w
        gfx.BeginPath()
        gfx.ImageRect(xpos - 29, ypos, w, h, timeColon, 1, 0)

        xpos = xpos + 32
        tens, ones = math.floor(seconds // 10), math.floor(seconds % 10)
        gfx.BeginPath()
        gfx.ImageRect(xpos, ypos, w, h, timeNumbers[tens + 1], 1, 0)
        gfx.BeginPath()
        gfx.ImageRect(xpos + w, ypos, w, h, timeNumbers[ones + 1], 1, 0)
    else
        gfx.BeginPath()
        local xpos, ypos = Dim.design.width - 270, footerY + 55
        local w, h = gfx.ImageSize(timeImage)
        gfx.ImageRect(xpos, ypos, w, h, timeImage, 1, 0)

        -- Draw only seconds
        local tens, ones = math.floor(time_s // 10), math.floor(time_s % 10)
        w, h = 90, 90
        xpos, ypos = xpos + 55, footerY - 16
        gfx.BeginPath()
        gfx.ImageRect(xpos, ypos, w, h, timeNumbers[tens + 1], 1, 0)
        gfx.BeginPath()
        gfx.ImageRect(xpos + w, ypos, w, h, timeNumbers[ones + 1], 1, 0)
    end
end

local function drawFooter()
    gfx.BeginPath()
    gfx.FillColor(0, 0, 0, BAR_ALPHA)
    gfx.Rect(0, footerY, Dim.design.width, FOOTER_HEIGHT)
    gfx.Fill()

    -- Timer
    local showTimer = enableTimer and (freezeTimer ~= -1 or GameConfig["EventMode"] == "True")
    if showTimer then
        -- Show dynamic timer
        if freezeTimer ~= -1 then
            drawTimer(freezeTimer, freezeTimer > 59)
        else
            drawTimer(timeOut, demoIdleTime and demoIdleTime > 59)
        end
        gfx.BeginPath()
        local w, h = gfx.ImageSize(creditImage)
        gfx.ImageRect(Dim.design.width - 190, footerY + 95, w, h, creditImage, 1, 0)
    else
        -- Show static image
        gfx.BeginPath()
        gfx.ImageRect(Dim.design.width - 275, footerY - 25, 328 * 0.85, 188 * 0.85, footerRightImage, 1, 0)
    end

    -- Version String
    gfx.BeginPath()
    gfx.LoadSkinFont("Digital-Serial-Bold.ttf")
    gfx.FontSize(20)
    gfx.TextAlign(gfx.TEXT_ALIGN_LEFT + gfx.TEXT_ALIGN_TOP)
    gfx.FillColor(255, 255, 255, 255)
    gfx.Text("EXPERIMENTALGEAR " .. version.MAJOR .. "." .. version.MINOR .. "." .. version.PATCH .. "", 8, 1895)
end

local function progressTransitions(deltaTime)
    entryTransitionScale = entryTransitionScale + deltaTime / 0.3
    if (entryTransitionScale > 1) then entryTransitionScale = 1 end

    entryTransitionFooterYOffset = FOOTER_HEIGHT * (1 - entryTransitionScale)
    footerY = Dim.design.height - FOOTER_HEIGHT + entryTransitionFooterYOffset

    timeOut = math.max(timeOut - deltaTime, 0)
end

local function draw(deltaTime, params)
    if params and params.noEnterTransition then
        entryTransitionScale = 1
    end

    gfx.Save()

    gfx.ResetTransform()

    Dim.updateResolution()

    Dim.transformToScreenSpace()

    gfx.LoadSkinFont("NotoSans-Regular.ttf")

    drawFooter()

    progressTransitions(deltaTime)

    gfx.Restore()
end

return {set = set, draw = draw, resetTimer = resetTimer}
