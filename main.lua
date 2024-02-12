-- the entrypoint
local function load()
    table = require("Framework.Libraries.Table")
    string = require("Framework.Libraries.String")
    math = require("Framework.Libraries.Math")
    Enum = require("Framework.Libraries.Enum")

    Class = require("Framework.Class")

    Maid = require("Framework.DataTypes.Maid")
    Signal = require("Framework.DataTypes.Signal")

    Vector2 = require("Framework.DataTypes.Vector2")
    CFrame = require("Framework.DataTypes.CFrame")
    Color4 = require("Framework.DataTypes.Color4")
    UDim = require("Framework.DataTypes.UDim")
    UDim2 = require("Framework.DataTypes.UDim2")

    NumberRange = require("Framework.DataTypes.NumberRange")
    NumberSequence = require("Framework.DataTypes.NumberSequence")
    ColorSequence = require("Framework.DataTypes.ColorSequence")

    Class.LoadDirectory("Framework", true)
    Class.LoadDirectory("Game", true)

    print("Start loading")
    Class.Begin()
    print("done loading")
    -- require("Game.main")

    local run = game:GetService("RunService")
    local lastDT = 1/60
    local frames = {}

    local goodFPS = Color4.fromRGB(0, 255, 0, 255)
    local okFPS = Color4.fromRGB(255, 255, 0, 255)
    local stinkyFPS = Color4.fromRGB(255, 0, 0, 255)
    
    local function DrawFrameCount(dt, x,y, s)
        local fps = math.floor(1/lastDT+0.5)
        if fps < 15 then
            stinkyFPS:Apply()
        elseif fps < 30 then
            okFPS:Apply()
        else
            goodFPS:Apply()
        end
        love.graphics.drawCustomText(tostring(fps), x,y,s)
    end

    run.Update:Connect(function(dt)
        local t = os.clock()
        for i = #frames, 1, -1 do
            if t - frames[i][1] > 1 then
                table.remove(frames, i)
            end
        end

        lastDT = dt
        table.insert(frames, {t, dt})
    end)

    run.Draw:Connect(function()
        local currentFrame = frames[#frames]
        -- local lowestFrame = math.huge
        -- local highestFrame = -math.huge
        
        -- for i, v in ipairs(frames) do
        --     lowestFrame = math.min(lowestFrame, v[2])
        --     highestFrame = math.max(highestFrame, v[2])
        -- end

        DrawFrameCount(currentFrame, 20, 20, 1)
        -- DrawFrameCount(highestFrame, 20, 40, 1)
        -- DrawFrameCount(lowestFrame, 20, 60, 1)
    end)

    love.window.setMode(800, 600)
end

local function update(dt)
    local run = game:GetService("RunService")
    run.Update:Fire(dt)
end

local function draw()
    local run = game:GetService("RunService")
    if game.Camera then
        local cameraTransform = game.Camera:GetTransform()
        love.graphics.push()
        love.graphics.translate(cameraTransform.CFrame.X - cameraTransform.Size.X/2, cameraTransform.CFrame.Y - cameraTransform.Size.Y/2)
    end
    run.Draw:Fire()
    if game.Camera then
        love.graphics.pop()
    end
end

love.load = load
love.update = update
love.draw = draw