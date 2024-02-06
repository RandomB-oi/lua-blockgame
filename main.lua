-- the entrypoint
local function load()
    table = require("Framework.Libraries.Table")
    string = require("Framework.Libraries.String")
    math = require("Framework.Libraries.Math")
    Enum = require("Framework.Libraries.Enum")

    Class = require("Framework.Class")

    Maid = require("Framework.Maid")
    Signal = require("Framework.Signal")

    Vector2 = require("Framework.Vector2")
    CFrame = require("Framework.CFrame")
    Color4 = require("Framework.Color4")

    Class.LoadDirectory("Framework", true)
    Class.LoadDirectory("Game", true)

    print("Start loading")
    Class.Begin()
    print("done loading")
    -- require("Game.main")
end

local function update(dt)
    local run = GetService("RunService")
    run.Update:Fire(dt)
end

local function draw()
    local run = GetService("RunService")
    run.Draw:Fire()
end

love.load = load
love.update = update
love.draw = draw