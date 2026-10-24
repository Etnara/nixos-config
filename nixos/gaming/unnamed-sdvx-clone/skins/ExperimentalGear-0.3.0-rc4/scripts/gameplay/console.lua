
local Dimensions = require 'common.dimensions'

local CONSOLE_W = 1352;
local CONSOLE_H = 712;

local function createConsoleImage(name)
    return gfx.CreateSkinImage("gameplay/console/"..name..".png", 0)
end

local function renderConsoleImage(image, alpha)
    gfx.BeginPath();
    gfx.ImageRect(
        -CONSOLE_W/2,
        -CONSOLE_H/2+350,
        CONSOLE_W,
        CONSOLE_H,
        image,
        alpha,
        0
    );
end

local consoleBaseImage = createConsoleImage("base")

local buttonGlowImages = {
    [0] = createConsoleImage("glow_bta"),
    createConsoleImage("glow_btb"),
    createConsoleImage("glow_btc"),
    createConsoleImage("glow_btd"),
    createConsoleImage("glow_fxl"),
    createConsoleImage("glow_fxr"),
};

local knobGlowImages = {
    [0] = createConsoleImage("glow_voll"),
    createConsoleImage("glow_volr"),
};

local lastKnobState = {
    [0] = -1,
    -1
};

local doFlash = true;

local render = function (deltaTime, critLineCenterX, critLineCenterY, critLineRotation)
    local resx, resy = game.GetResolution();
    if (resx > resy) then
        return
    end

    Dimensions.setUpTransforms(
        critLineCenterX,
        critLineCenterY,
        critLineRotation
    )

    renderConsoleImage(consoleBaseImage, 1)

    if doFlash then
        for button=0,5 do
            if game.GetButton(button) then
                renderConsoleImage(buttonGlowImages[button], 0.75)
            end
        end

        -- Knobs also work
        -- commented out do to missing/incorrect textures

        --[[
        for knob=0,1 do
            local state = game.GetKnob(knob)

            if state ~= lastKnobState[knob] then
                renderConsoleImage(knobGlowImages[knob], 1)

                lastKnobState[knob] = state
            end
        end
        ]]
    end

    doFlash = not doFlash;
end

return {
    render=render
}