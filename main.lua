-- the entrypoint
local function load()
    table = require("Framework.Libraries.Table")
    string = require("Framework.Libraries.String")
    math = require("Framework.Libraries.Math")

    Class = require("Framework.Class")

    Maid = require("Framework.Maid")
    Signal = require("Framework.Signal")

    Vector2 = require("Framework.Vector2")
    CFrame = require("Framework.CFrame")


    Class.LoadDirectory("Framework", true)
    Class.LoadDirectory("Game", true)

    Class.Begin()
end

local function update(dt)
end

local function draw()
end

love.load = load
love.update = update
love.draw = draw